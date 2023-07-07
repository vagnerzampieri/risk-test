# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnalysisRiskService, type: :service do
  describe '#call' do
    subject(:service) { described_class.new(params) }

    let(:params) do
      {
        transaction_id: transaction.id,
        user_id: user.id
      }
    end
    let(:user) { create(:user) }
    let(:transaction) { create(:transaction, user: user) }

    context 'when transaction is approved' do
      it 'returns recommendation' do
        expect(service.call).to eq(
          transaction_id: transaction.id,
          recommendation: 'approve'
        )
      end
    end

    context 'when transaction is denied' do
      before do
        create(:transaction, user: user, has_cbk: true)
      end

      it 'returns recommendation' do
        expect(service.call).to eq(
          transaction_id: transaction.id,
          recommendation: 'deny'
        )
      end
    end
  end
end
