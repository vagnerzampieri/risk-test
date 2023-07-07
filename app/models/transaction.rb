# frozen_string_literal: true

class Transaction < ApplicationRecord
  encrypts :card_number, deterministic: true

  belongs_to :merchant
  belongs_to :user
  belongs_to :device, optional: true
end
