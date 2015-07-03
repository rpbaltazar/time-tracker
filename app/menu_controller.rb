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

    # TODO: The idea with this is to keep track of the existing rows
    # and update the text contents instead of redrawing the menu every app update
    @appList = []
  end

  def updateMenuContents(newMenu, times)
    mainMenu = buildStatusBarMenu
    newMenu.each_with_index do |menuItemContent, index|
      menuItem = NSMenuItem.new
      menuItem.title = "#{menuItemContent}: #{times[index]}"
      menuItem.keyEquivalent = ''
      menuItem.action = nil
      mainMenu.insertItem(menuItem, atIndex: 0)
      @appList << menuItem
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
