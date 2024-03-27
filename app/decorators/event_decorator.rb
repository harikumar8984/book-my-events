# frozen_string_literal: true

class EventDecorator < BaseDecorator
  def available_tickets
    total_tickets.to_i - booked_tickets
  end

  def booked_tickets
    tickets.where(status: :booked).count
  end
end
