# frozen_string_literal: true

class TicketAvailabilityFacade < Base
  AVAILABILITY_KLASS = {
    'Event' => Events::AvailabilityService,
    'Event::Booking' => Events::Tickets::AvailabilityService
  }.freeze

  def initialize(record)
    @record = record
  end

  def call
    AVAILABILITY_KLASS[record.class.name].call(record)
  end

  private

  attr_reader :record
end
