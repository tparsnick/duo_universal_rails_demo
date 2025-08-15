# Point Bundler to the Gemfile for this app
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

# Set up gems listed in the Gemfile
require 'bundler/setup'