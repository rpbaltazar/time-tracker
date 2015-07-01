class WindowManagerController
  def initialize
    workspace = NSWorkspace.sharedWorkspace
    notificationCenter = workspace.notificationCenter

    notificationCenter.addObserver(self,
                                    selector: 'activeAppDidChange:',
                                    name: 'NSWorkspaceDidActivateApplicationNotification',
                                    object: nil)
    self
  end

  def activeAppDidChange(notification)
    currentApp = notification.userInfo['NSWorkspaceApplicationKey'].localizedName
    puts "#{Time.new}: #{currentApp}"
  end
end
