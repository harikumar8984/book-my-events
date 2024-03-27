# frozen_string_literal: true

class Events::ReserveTicketJob < ApplicationJob
	queue_as :default

	def perform(user_id, event_id, quantity)
	  event = Event.find(event_id)
	  Events::Tickets::ReservationService.call(user_id, event, quantity)
	end
end

