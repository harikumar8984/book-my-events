# frozen_string_literal: true

class Events::AvailabilityService < Base
  def initialize(event)
    @event = event
  end

  def call
    return unless event

    validate_ticket_availabilty
  end

  private

  attr_reader :event

  delegate :available_tickets, :errors, to: :event

  def validate_ticket_availabilty
    return true if available_tickets.positive?

    errors.add(:total_tickets, :not_available)
  end
end
