# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Events::TicketsController', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }
  let(:event) { create(:event, user: user) }

  before do
    sign_in user
  end

  describe 'GET /events/:event_id/tickets/new' do
    it 'returns a success response' do
      get new_events_event_ticket_path(event)
      expect(response).to be_successful
    end
  end

  describe 'POST /events/:event_id/tickets' do
    it 'queues a background job to create a new ticket' do
      expect do
        post events_event_tickets_path(event), params: { event_ticket: { quantity: 2 } }
      end.to have_enqueued_job(Events::ReserveTicketJob)
        .with(user.id, event.id, '2') # Ensure correct arguments are passed to the job
    end

    it 'redirects to event after creating ticket' do
      post events_event_tickets_path(event), params: { event_ticket: { quantity: 2 } }
      expect(response).to redirect_to(events_event_tickets_path(event))
      expect(flash[:notice]).to eq('Booking request queued for processing. Please wait while we process your request.')
    end
  end

  # describe 'GET /events/tickets' do
  #   it 'returns a success response' do
  #     get events_tickets_path
  #     expect(response).to be_successful
  #   end
  # end
end
