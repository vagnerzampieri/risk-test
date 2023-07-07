# frozen_string_literal: true

Rails.application.routes.draw do
  post '/recommendations', to: 'recommendations#create'
end
