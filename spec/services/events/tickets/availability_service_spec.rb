# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::Tickets::AvailabilityService, type: :service do
  let(:user) { create(:user) }
  let(:event) { create(:event, total_tickets: 100) }
  let(:booking) { create(:event_booking, event: event, quantity: 2) }

  subject { described_class.new(booking) }

  describe '#call' do
    context 'when tickets are available' do
      it 'returns true' do
        expect(subject.call).to be_truthy
      end
    end

    context 'when tickets are not available' do
      before do 
        booking.update(quantity: 100, status: :booked)
        create_tickets(100) 
      end  

      it 'adds error to booking' do
        subject.call
        expect(booking.errors[:quantity].first).to include('Tickets are not available.')
      end
    end
  end
  def create_tickets(quantity)
    quantity.times { event.tickets.create(status: :booked) }
  end
end
