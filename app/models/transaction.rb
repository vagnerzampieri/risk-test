# frozen_string_literal: true

class Transaction < ApplicationRecord
  encrypts :card_number

  belongs_to :merechant
  belongs_to :user
  belongs_to :device
end
