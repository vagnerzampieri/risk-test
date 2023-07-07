# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module RiskTest
  class Application < Rails::Application
    config.load_defaults 7.0
    config.time_zone = 'America/Sao_Paulo'
    config.api_only = true
    config.autoload_paths << "#{root}/app/services"
    config.generators.test_framework :rspec
    config.active_record.encryption.key_derivation_salt =
      Rails.application.credentials[:active_record_encryption][:key_derivation_salt]
  end
end
