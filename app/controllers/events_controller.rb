# frozen_string_literal: true

class EventsController < ApplicationController
  include Authorizeable
  before_action :load_event, only: %i[show edit update]
  before_action :load_bookings, only: :index

  def index
    @events = Event.all.includes(:user, :bookings).order(:event_at).page(params[:page]).per(10)
  end

  def show; end

  def new
    @event = current_user.events.build
  end

  def edit; end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to @event, notice: 'Event created successfully.'
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event updated successfully.'
    else
      render :edit
    end
  end

  private

  def load_event
    @event = Event.find(params[:id])
  end

  def load_bookings
    @booked_tickets = current_user.bookings.joins(:event).group('events.id').sum(:quantity)
  end  

  def event_params
    params.require(:event).permit(:name, :description, :location, :event_at, :total_tickets, :user_id)
  end
end
