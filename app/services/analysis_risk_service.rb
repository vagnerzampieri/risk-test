# frozen_string_literal: true

class AnalysisRiskService
  def initialize(params)
    @params = params
  end

  def call
    {
      transaction_id: params[:transaction_id].to_i,
      recommendation:
    }
  end

  private

  attr_reader :params

  def user_transactions
    @user_transactions ||= Transaction.select(:user_id, :reference_at, :amount, :has_cbk)
                                      .where(user_id: params[:user_id])
  end

  def recent_transactions
    @recent_transactions ||= user_transactions.where('reference_at > ?', 30.minutes.ago)
  end

  def more_than_5_transactions?
    (recent_transactions.size + 1) > 5
  end

  def amount_greater_than_3000?
    (recent_transactions.sum(:amount) + params[:amount].to_d) > 3000
  end

  def recommendation
    return 'deny' if user_transactions.where(has_cbk: true).any?
    return 'deny' if more_than_5_transactions?
    return 'deny' if amount_greater_than_3000?

    'approve'
  end
end
