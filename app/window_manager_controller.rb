class WindowManagerController

  def initialize
    workspace = NSWorkspace.sharedWorkspace
    notificationCenter = workspace.notificationCenter

    notificationCenter.addObserver(self,
                                    selector: 'activeAppDidChange:',
                                    name: 'NSWorkspaceDidActivateApplicationNotification',
                                    object: nil)

    resetCounters
    self
  end

  def activeAppDidChange(notification)
    newAppName = notification.userInfo['NSWorkspaceApplicationKey'].localizedName
    updateTracker newAppName
  end

  def getAppTimes
    tempAccumulatedTimes = @accumulatedTimes.clone
    tempAccumulatedTimes[@lastAppName] += computeTimeDifference @lastTrackedApp
    inverseSortedApps = tempAccumulatedTimes.sort_by { |k, v| v }
    puts "temporary acc Times= #{tempAccumulatedTimes}"
    inverseSortedApps
  end

  private

  def resetCounters
    @recordedData = {}
    # NOTE: Used to keep track/fast access to accumulated times
    @lastAppName = nil
    @accumulatedTimes = {}
    @lastTrackedApp = nil
  end

  def updateTracker(newAppName)
    currentTime = Time.now

    if @recordedData[newAppName].nil?
      @recordedData[newAppName] = []
      @accumulatedTimes[newAppName] = 0
    end
    @recordedData[newAppName] << { start_time: currentTime }

    if not @lastTrackedApp.nil?
      @lastTrackedApp[:end_time] = currentTime
      @accumulatedTimes[@lastAppName] += computeTimeDifference @lastTrackedApp
    end

    @lastTrackedApp = @recordedData[newAppName].last
    @lastAppName = newAppName
  end

  def computeTimeDifference(appData)
    startTime = appData[:start_time]
    endTime = appData[:end_time] || Time.now
    timeDiff = endTime - startTime
    timeDiff.to_i
  end
end
