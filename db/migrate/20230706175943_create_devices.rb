# frozen_string_literal: true

class CreateDevices < ActiveRecord::Migration[7.0]
  def change
    create_table :devices do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :ip

      t.timestamps
    end
  end
end
