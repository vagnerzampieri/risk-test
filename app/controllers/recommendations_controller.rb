# frozen_string_literal: true

class RecommendationsController < ApplicationController
  def create
    analysis_risk = AnalysisRiskService.new(recommendation_params)

    render json: analysis_risk.call, status: :ok
  end

  private

  def recommendation_params
    params.permit(:transaction_id, :merchant_id, :user_id, :card_number,
                  :transaction_date, :transaction_amount, :device_id)
  end
end
