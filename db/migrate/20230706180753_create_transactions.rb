# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :merechant, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :card_number
      t.datetime :reference_date
      t.references :device, null: false, foreign_key: true
      t.boolean :has_cbk

      t.timestamps
    end
  end
end
