# frozen_string_literal: true

FactoryBot.define do
  factory :device do
    user
    name { 'Mobile' }
    ip { Faker::Internet.ip_v4_address }
  end
end
