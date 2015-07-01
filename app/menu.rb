class AppDelegate
  def buildMenu
    @mainMenu = NSMenu.new
    appName = NSBundle.mainBundle.infoDictionary['CFBundleName']

    @mainMenu.addItemWithTitle("Quit #{appName}", action: 'terminate:', keyEquivalent: 'q')
    @mainMenu.addItem(NSMenuItem.separatorItem)
    @mainMenu.addItemWithTitle("About #{appName}", action: 'orderFrontStandardAboutPanel:', keyEquivalent: '')
  end

  private

  def addMenu(title, &b)
    item = createMenu(title, &b)
    @mainMenu.addItem item
    item
  end

  def createMenu(title, &b)
    menu = NSMenu.alloc.initWithTitle(title)
    menu.instance_eval(&b) if b
    item = NSMenuItem.alloc.initWithTitle(title, action: nil, keyEquivalent: '')
    item.submenu = menu
    item
  end
end
