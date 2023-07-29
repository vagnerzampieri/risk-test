# frozen_string_literal: true

class AddIndexesToTables < ActiveRecord::Migration[7.0]
  def change
    add_index :merchants, :name
    add_index :transactions, :has_cbk
    add_index :transactions, :amount
    add_index :users, :name
  end
end
