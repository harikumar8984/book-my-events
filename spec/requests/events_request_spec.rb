# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Events', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }
  let(:event) { create(:event, user: user) }

  before do
    sign_in user
  end

  describe 'GET /events' do
    it 'returns a successful response' do
      get events_path
      expect(response).to be_successful
    end

    it 'paginates events' do
      create_list(:event, 15, user: user) # Create more events for pagination test
      get events_path
      expect(response.body).to include('Next')
    end
  end

  describe 'GET /events/:id' do
    it 'returns a successful response' do
      get event_path(event)
      expect(response).to be_successful
    end
  end

  describe 'creating a new event' do
    it 'creates a new event' do
      expect do
        post events_path, params: { event: attributes_for(:event) }
      end.to change(Event, :count).by(1)
    end

    context 'with valid parameters' do
      let(:valid_params) do
        {
          event: {
            name: 'Test Event',
            description: 'This is a test event',
            location: 'Test Location',
            event_at: Date.today,
            total_tickets: 100
          }
        }
      end

      it 'creates a new event with valid parameters' do
        expect do
          post events_path, params: valid_params
        end.to change(Event, :count).by(1)
      end

      it 'redirects to the created event page' do
        post events_path, params: valid_params
        expect(response).to redirect_to(Event.last)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new event' do
        expect do
          post events_path, params: { event: { name: '', location: '', event_at: '', total_tickets: '' } }
        end.to_not change(Event, :count)
      end
    end
  end
end
