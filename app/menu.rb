class AppDelegate
  def buildStatusBarMenu
    @mainMenu = NSMenu.new
    appName = NSBundle.mainBundle.infoDictionary['CFBundleName']

    # @mainMenu.addItem(NSMenuItem.separatorItem)
    @mainMenu.addItemWithTitle("About #{appName}", action: 'orderFrontStandardAboutPanel:', keyEquivalent: '')
    @mainMenu.addItem(NSMenuItem.separatorItem)
    @mainMenu.addItemWithTitle("Quit #{appName}", action: 'terminate:', keyEquivalent: 'q')
  end
end
