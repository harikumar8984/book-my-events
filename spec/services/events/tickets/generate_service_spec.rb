# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::Tickets::GenerateService, type: :service do
  let(:event) { create(:event) }

  describe '#call' do
    it 'generates tickets for the event' do
      service = described_class.new(event)
      expect { service.call }.to change(Event::Ticket, :count).by(event.total_tickets)

      expect(Event::Ticket.pluck(:event_id)).to all(eq(event.id))
      expect(Event::Ticket.pluck(:status)).to all(eq('available'))
    end
  end
end
