# frozen_string_literal: true

class Events::Tickets::GenerateService < Base
  def initialize(event)
    @event = event
  end

  def call
    generate_tickets
  end

  private

  attr_reader :event

  def generate_tickets
    Event::Ticket.insert_all(ticket_attributes)
  end

  def ticket_attributes
    (1..event.total_tickets).map { { event_id: event.id, status: :available } }
  end
end
