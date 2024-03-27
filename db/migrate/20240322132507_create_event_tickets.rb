# frozen_string_literal: true

class CreateEventTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :event_tickets do |t|
      t.references :user,  null: true, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
