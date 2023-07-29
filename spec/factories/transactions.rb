# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    user
    device
    merchant
    card_number { '434505******9116' }
    amount { 373 }
    has_cbk { false }
  end
end
