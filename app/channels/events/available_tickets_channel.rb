class Events::AvailableTicketsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "available_tickets_channel_#{params[:event_id]}"
  end

  def unsubscribed;end
end
