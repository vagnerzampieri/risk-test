# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Recommendations', type: :request do
  describe 'POST /create' do
    subject(:create_recommendation) do
      post '/recommendations', params:, headers: { 'Authorization' => "Bearer #{token}" }
    end

    let(:params) do
      {
        transaction_id: transaction.id,
        user_id: user.id
      }
    end

    let(:token) { Rails.application.credentials.mobile_client.token }
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

    context 'whithout token' do
      let(:token) { nil }

      it 'returns http unauthorized' do
        create_recommendation

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
