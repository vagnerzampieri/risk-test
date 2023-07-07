# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it { is_expected.to belong_to(:merchant) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:device).optional }
end
