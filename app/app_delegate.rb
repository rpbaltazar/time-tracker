class AppDelegate
  def applicationDidFinishLaunching(notification)
    buildMenu
    timeTrackerImage = NSImage.imageNamed 'status_bar_icon'
    timeTrackerImage.setSize(NSMakeSize(16,16))

    statusBar = NSStatusBar.systemStatusBar
    @item = statusBar.statusItemWithLength -1
    @item.setImage timeTrackerImage
    @item.setMenu @mainMenu

    lastActiveApp = nil
    while true do
      currentActiveApp = NSWorkspace.sharedWorkspace().activeApplication()
      if lastActiveApp.nil? || currentActiveApp['NSApplicationName'] != lastActiveApp
        lastActiveApp = currentActiveApp['NSApplicationName']
        puts "#{Time.new}: #{lastActiveApp}"
        sleep 1
      end
    end
  end
end
