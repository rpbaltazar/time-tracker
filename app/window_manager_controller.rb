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

  def getAppList
    @invertedAppList
  end

  def getAppTimes
    @times
  end

  private

  def resetCounters
    @trackedTimes = {}
    @lastAppName = nil
    @lastAppTime = nil
    # TODO: Change these to an hash e.g. sorted apps
    @invertedAppList = []
    @times = []
  end

  def updateTracker newAppName
    currentTime = Time.now

    if @trackedTimes[newAppName].nil?
      newApp newAppName, currentTime
    else
      @trackedTimes[newAppName][:times] << Time.now
    end

    updatePreviousAppAccumulated currentTime
    sortAppsByAccumulated

    @lastAppName = newAppName
    @lastAppTime = currentTime
  end

  def updatePreviousAppAccumulated currentTime
    if !@lastAppTime.nil? && !@lastAppName.nil?
      timeSpent = currentTime - @lastAppTime
      @trackedTimes[@lastAppName][:accumulated] += timeSpent
    end
  end

  def newApp appName, currentTime
    @trackedTimes[appName] = {
      times: [currentTime],
      accumulated: 0
    }
  end

  def sortAppsByAccumulated
    @invertedAppList, @times = buildAppNamesAndTimesList
  end

  def buildAppNamesAndTimesList
    inverseSortedApps = @trackedTimes.sort_by { |k, v| v[:accumulated] }
    appNames = []
    accumulatedTimes = []
    inverseSortedApps.each{|elm|
      appNames << elm[0]
      timeHHMM = computeHoursMins elm[1][:accumulated]
      accumulatedTimes << timeHHMM
    }
    return appNames, accumulatedTimes
  end

  def computeHoursMins totalSeconds
    hours = (totalSeconds / 3600).floor
    remainingSeconds = totalSeconds - 3600*hours
    minutes = (remainingSeconds / 60).floor
    return "#{hours}:#{minutes}"
  end
end
