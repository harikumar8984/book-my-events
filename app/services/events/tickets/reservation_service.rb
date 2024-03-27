# frozen_string_literal: true

class Events::Tickets::ReservationService < Base
  def initialize(user_id, event, quantity)
    @user_id = user_id
    @event = event
    @quantity = quantity.to_i
  end

  def call
    reserve_tickets
    broadcast_reservation
  rescue StandardError => e
    Rails.logger.error "Error during ticket reservation: #{e.message}"
    notify
  end

  private

  attr_reader :user_id, :event, :quantity

  def reserve_tickets
    Event::Booking.transaction do
     Event::Booking.create!(
        user_id: user_id,
        event_id: event.id,
        quantity: quantity,
        status: :booked
      )
      event.tickets.lock(true).where(status: :available).limit(quantity).update_all(
        status: :booked,
        user_id: user_id
      )
    end
  end

  def broadcast_reservation
    ActionCable.server.broadcast(
      "available_tickets_channel_#{event.id}",
      broadcast_message
    )
  end

   def broadcast_message
    {}.tap do |msg|
      msg[:id] = event.id
      msg[:available_tickets] = event.available_tickets
      msg[:booked_tickets] = event.booked_tickets
    end.as_json
  end

  #TODO implementation required
  def notify;end  
end
