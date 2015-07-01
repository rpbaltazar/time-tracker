class AppDelegate
  def applicationDidFinishLaunching(notification)
    buildStatusBarMenu
    timeTrackerImage = NSImage.imageNamed 'status_bar_icon'
    timeTrackerImage.setSize(NSMakeSize(16,16))

    statusBar = NSStatusBar.systemStatusBar
    # NOTE: -1 comes from StackOverflow answer
    # http://stackoverflow.com/questions/24024723/swift-using-nsstatusbar-statusitemwithlength-and-nsvariablestatusitemlength
    @item = statusBar.statusItemWithLength -1
    @item.setImage timeTrackerImage
    @item.setMenu @mainMenu

    @windowController = WindowManagerController.new
  end
end
