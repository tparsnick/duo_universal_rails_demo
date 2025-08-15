require_relative 'boot'
require 'rails'

# Pick the frameworks you want:
require 'action_controller/railtie'
require 'action_view/railtie'

module DuoUniversalRailsDemo
  class Application < Rails::Application
    config.load_defaults 7.1
    #config.autoload_lib(ignore: %w(assets tasks))
  end
end
