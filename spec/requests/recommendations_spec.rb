# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Recommendations', type: :request do
  describe 'POST /create' do
    subject(:create_recommendation) { post '/recommendations', params: }

    let(:params) do
      {
        transaction_id: transaction.id,
        user_id: user.id
      }
    end
    let(:user) { create(:user) }
    let(:transaction) { create(:transaction, user:) }

    it 'returns http success' do
      create_recommendation

      expect(response).to have_http_status(:ok)
    end

    context 'when transaction is approved' do
      it 'returns recommendation' do
        create_recommendation

        expect(JSON.parse(response.body)).to eq(
          'transaction_id' => transaction.id,
          'recommendation' => 'approve'
        )
      end
    end

    context 'when transaction is denied' do
      context 'and user has cbk' do
        before do
          create(:transaction, user:, has_cbk: true)
        end

        it 'returns recommendation' do
          create_recommendation

          expect(JSON.parse(response.body)).to eq(
            'transaction_id' => transaction.id,
            'recommendation' => 'deny'
          )
        end
      end
    end
  end
end
