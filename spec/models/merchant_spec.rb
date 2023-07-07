# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { is_expected.to have_many(:transactions).dependent(:nullify) }
end
