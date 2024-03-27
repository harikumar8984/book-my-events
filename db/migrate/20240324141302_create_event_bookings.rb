# frozen_string_literal: true

class CreateEventBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :event_bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.integer :quantity
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
