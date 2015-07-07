class AppDelegate
  def applicationDidFinishLaunching(notification)
    @windowController = WindowManagerController.new
    @menuController = MenuController.alloc.initWithWindowController @windowController
  end
end
