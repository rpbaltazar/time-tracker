class AppDelegate
  def applicationDidFinishLaunching(notification)
    @menuController = MenuController.new
    @windowController = WindowManagerController.alloc.initWithMenuController @menuController
  end
end
