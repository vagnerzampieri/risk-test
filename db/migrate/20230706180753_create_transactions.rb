# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :merchant, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :card_number
      t.decimal :amount
      t.datetime :reference_at
      t.references :device, foreign_key: { allow_nil: true }
      t.boolean :has_cbk

      t.timestamps
    end
  end
end
