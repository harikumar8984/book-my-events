# frozen_string_literal: true

class Events::Tickets::AvailabilityService < Base
  def initialize(booking)
    @booking = booking
  end

  def call
    return unless booking

    validate_ticket_availabilty
  end

  private

  attr_reader :booking

  delegate :quantity, :errors, to: :booking
  delegate :available_tickets, to: 'booking.event'

  def validate_ticket_availabilty
    return true if available_tickets - quantity >= 0

    errors.add(:quantity, :not_available)
  end
end
