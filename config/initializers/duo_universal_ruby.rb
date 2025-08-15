
require "duo_universal_ruby"   #this is needed when using path in the Gemfile for local dev

Rails.configuration.duo_config =
  YAML.load_file(Rails.root.join("config", "duo.yml"))
