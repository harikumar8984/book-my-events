# frozen_string_literal: true

module AvailabilityValidatable
  extend ActiveSupport::Concern

  included do
    validate :ticket_availabilty
  end

  private

  def ticket_availabilty
    TicketAvailabilityFacade.call(self)
  end
end
