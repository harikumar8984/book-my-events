# frozen_string_literal: true
class Events::TicketsController < ApplicationController
  before_action :load_event, only: %i[new create]

  def index
    @user_bookings = current_user.bookings.includes(:event).where(event_id: params[:event_id])
  end

  def new
    @ticket = @event.tickets.build
  end

  def create
    Events::ReserveTicketJob.perform_later(current_user.id, @event.id, ticket_params[:quantity])
    flash[:notice] = 'Booking request queued for processing. Please wait while we process your request.'
    redirect_to events_event_tickets_path(@event)
  end

  private

  def load_event
    @event = Event.find(params[:event_id])
  end

  def ticket_params
    params.require(:event_ticket).permit(:quantity)
  end
end

