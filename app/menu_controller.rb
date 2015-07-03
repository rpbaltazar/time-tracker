class MenuController
  def initialize
    mainMenu = buildStatusBarMenu
    timeTrackerImage = NSImage.imageNamed 'status_bar_icon'
    timeTrackerImage.setSize(NSMakeSize(16,16))

    statusBar = NSStatusBar.systemStatusBar
    # NOTE: -1 comes from StackOverflow answer
    # http://stackoverflow.com/questions/24024723/swift-using-nsstatusbar-statusitemwithlength-and-nsvariablestatusitemlength
    @item = statusBar.statusItemWithLength -1
    @item.setImage timeTrackerImage
    @item.setMenu mainMenu
  end

  def updateMenuContents(newMenu)
    mainMenu = buildStatusBarMenu
    newMenu.each do |menuItem|
      mainMenu.insertItemWithTitle("#{menuItem}", action: nil, keyEquivalent: '', atIndex: 0)
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

    mainMenu
  end

end
