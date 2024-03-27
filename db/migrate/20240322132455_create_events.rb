# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :location
      t.datetime :event_at
      t.integer :total_tickets
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
