Rails.application.configure do
  # Reload application's code on every request. Good for development.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. Disabled by default.
  config.action_controller.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raises error for missing translations
  # config.i18n.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code
  # config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
