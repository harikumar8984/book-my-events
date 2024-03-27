# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :bookings, class_name: 'Event::Booking', dependent: :destroy
  has_many :tickets, class_name: 'Event::Ticket', dependent: :destroy
  has_many :events, dependent: :restrict_with_error
end
