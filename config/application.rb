require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module RiskTest
  class Application < Rails::Application
    config.load_defaults 7.0
    config.time_zone = 'America/Sao_Paulo'
    config.api_only = true
  end
end
