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
    # puts "----------------------------------------"
    # puts "#{@trackedTimes}"
  end

  private

  def resetCounters
    @trackedTimes = {}
    @lastAppName = nil
    @lastAppTime = nil
  end

  def updateTracker newAppName
    currentTime = Time.now

    if @trackedTimes[newAppName].nil?
      newApp newAppName, currentTime
    else
      @trackedTimes[newAppName][:times] << Time.now
    end

    updatePreviousAppAccumulated currentTime

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
end