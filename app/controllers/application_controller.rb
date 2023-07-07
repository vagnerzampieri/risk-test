# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      ActiveSupport::SecurityUtils.secure_compare(
        token,
        Rails.application.credentials.mobile_client.token
      )
    end
  end
end
