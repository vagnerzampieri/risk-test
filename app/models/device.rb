# frozen_string_literal: true

class Device < ApplicationRecord
  belongs_to :user

  has_many :transactions, dependent: :nullify
end
