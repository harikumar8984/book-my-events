# frozen_string_literal: true

class Event < ApplicationRecord
  include AvailabilityValidatable, Decorateable

  belongs_to :user, optional: true

  has_many :bookings, class_name: 'Event::Booking', dependent: :destroy
  has_many :tickets, class_name: 'Event::Ticket', dependent: :destroy

  validates :name, :location, :event_at, :total_tickets, presence: true

  after_commit -> { Events::GenerateTicketJob.perform_later(self) }, on: :create
end
