# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/osx'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'TimeTracker'
  app.icon = 'time_tracker.icns'
  app.info_plist['LSUIElement'] = true
  app.copyright = 'Copyright © 2015 Rui Baltazar'
  app.identifier = 'net.balazar.TimeTracker'
  app.version = '0.0.1a'
  app.codesign_for_release = false
  app.deployment_target = "10.9"
end
