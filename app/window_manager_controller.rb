class WindowManagerController

  def initWithMenuController(menuController)
    @menuController = menuController

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

  private

  def resetCounters
    @trackedTimes = {}
    @lastAppName = nil
    @lastAppTime = nil
    @invertedAppList = []
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
    invertedApps = @trackedTimes.sort_by { |k, v| v[:accumulated] }.map{|elm| elm[0]}
    # TODO:
    # Compute difference between new and old sorted array.
    # If changed, then update the menu
    # puts "sorted Apps: #{@invertedAppList}"
    if invertedApps != @invertedAppList
      @menuController.updateMenuContents invertedApps
      @invertedAppList = invertedApps
    end
  end
end
