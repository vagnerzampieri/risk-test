# frozen_string_literal: true

class AnalysisRiskService
  def initialize(params)
    @params = params
  end

  def call
    {
      transaction_id: params[:transaction_id],
      recommendation: recommendation
    }
  end

  private

  attr_reader :params

  def transactions
    @transactions ||= Transaction.where(user_id: params[:user_id])
  end

  def recommendation
    return 'deny' if transactions.where(has_cbk: true).any?

    'approve'
  end
end
