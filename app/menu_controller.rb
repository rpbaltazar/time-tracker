class MenuController

  def initWithWindowController(windowController)
    mainMenu = buildStatusBarMenu

    timeTrackerImage = NSImage.imageNamed 'status_bar_icon'
    timeTrackerImage.setSize(NSMakeSize(16,16))

    statusBar = NSStatusBar.systemStatusBar
    # NOTE: -1 comes from StackOverflow answer
    # http://stackoverflow.com/questions/24024723/swift-using-nsstatusbar-statusitemwithlength-and-nsvariablestatusitemlength
    @item = statusBar.statusItemWithLength -1
    @item.setImage timeTrackerImage
    @item.setMenu mainMenu

    @windowController = windowController
    self
  end

  # TODO: update order list or times only
  # TODO: send current time to get latest app most recent time
  def menuWillOpen(menu)
    mainMenu = buildStatusBarMenu
    appListWithTimes = @windowController.getAppTimes
    appListWithTimes.each do |appData|
    # @windowController.getAppList.each_with_index do |menuItemContent, index|
      menuItem = NSMenuItem.new
      menuItem.title = "#{appData[0]}: #{computeHoursMins appData[1]}"
      menuItem.keyEquivalent = ''
      menuItem.action = nil
      mainMenu.insertItem(menuItem, atIndex: 0)
    end
    @item.setMenu mainMenu
  end

  private

  def buildStatusBarMenu
    mainMenu = NSMenu.new
    appName = NSBundle.mainBundle.infoDictionary['CFBundleName']

    mainMenu.addItem(NSMenuItem.separatorItem)
    mainMenu.addItemWithTitle("About #{appName}", action: 'orderFrontStandardAboutPanel:', keyEquivalent: '')
    mainMenu.addItem(NSMenuItem.separatorItem)
    mainMenu.addItemWithTitle("Quit #{appName}", action: 'terminate:', keyEquivalent: 'q')

    mainMenu.setDelegate self

    mainMenu
  end

  def computeHoursMins totalSeconds
    hours = (totalSeconds / 3600).floor
    remainingSeconds = totalSeconds - 3600*hours
    minutes = (remainingSeconds / 60).floor
    return "#{hours}:#{minutes}"
  end

end
