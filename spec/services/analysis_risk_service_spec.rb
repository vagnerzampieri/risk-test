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
    let(:transaction) { create(:transaction, user:) }

    context 'when transaction is approved' do
      it 'returns recommendation' do
        expect(service.call).to eq(
          transaction_id: transaction.id,
          recommendation: 'approve'
        )
      end
    end

    context 'when transaction is denied' do
      context 'and user has cbk' do
        before do
          create(:transaction, user:, has_cbk: true)
        end

        it 'returns recommendation' do
          expect(service.call).to eq(
            transaction_id: transaction.id,
            recommendation: 'deny'
          )
        end
      end

      context 'and user has more than 5 transactions in the last 30 minutes' do
        before do
          create_list(:transaction, 6, user:, reference_at: 29.minutes.ago)
        end

        it 'returns recommendation' do
          expect(service.call).to eq(
            transaction_id: transaction.id,
            recommendation: 'deny'
          )
        end
      end

      context 'and user has a transaction with amount greater than 3000 in the last 30 minutes' do
        before do
          create(:transaction, user:, amount: 3001, reference_at: 29.minutes.ago)
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
end
