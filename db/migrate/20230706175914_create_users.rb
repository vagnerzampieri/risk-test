# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.references :merchant, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
