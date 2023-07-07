# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    user
    device
    merchant
    card_number { '434505******9116' }
    reference_at { '2019-11-31T23:16:32.812632' }
    amount { 373 }
    has_cbk { false }
  end
end
