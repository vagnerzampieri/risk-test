# frozen_string_literal: true

class AnalysisRiskService
  def initialize(params)
    @params = params
  end

  def call
    {
      transaction_id: params[:transaction_id],
      recommendation:
    }
  end

  private

  attr_reader :params

  def user_transactions
    @user_transactions ||= Transaction.where(user_id: params[:user_id])
  end

  def recent_transactions
    @recent_transactions ||= user_transactions.where('reference_at > ?', 30.minutes.ago)
  end

  def recommendation
    return 'deny' if user_transactions.where(has_cbk: true).any?
    return 'deny' if recent_transactions.count > 5
    return 'deny' if recent_transactions.where('amount > ?', 3000).any?

    'approve'
  end
end
