# frozen_string_literal: true

class RemoveReferenceAtToTransactions < ActiveRecord::Migration[7.0]
  def change
    remove_column :transactions, :reference_at, :datetime
  end
end
