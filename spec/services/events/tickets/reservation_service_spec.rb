# spec/services/events/tickets/reservation_service_spec.rb

require 'rails_helper'

RSpec.describe Events::Tickets::ReservationService, type: :service do
  let(:user) { create(:user) }
  let(:event) { create(:event, total_tickets: 10) }

  describe '#call' do
    context 'when reservation succeeds' do
      it 'reserves tickets and broadcasts available tickets' do
        quantity = 2

        expect(Event::Booking).to receive(:transaction).once.and_yield
        expect(Event::Booking).to receive(:create!).once.with(
          user_id: user.id,
          event_id: event.id,
          quantity: quantity,
          status: :booked
        )

        tickets = instance_double(ActiveRecord::Relation)
        expect(event.tickets).to receive(:lock).once.with(true).and_return(tickets)
        expect(tickets).to receive(:where).once.with(status: :available).and_return(tickets)
        expect(tickets).to receive(:limit).once.with(quantity).and_return(tickets)
        expect(tickets).to receive(:update_all).once.with(
          status: :booked,
          user_id: user.id
        )

        expect(ActionCable.server).to receive(:broadcast).once.with(
          "available_tickets_channel_#{event.id}",
          {
            "id" => event.id,
            "available_tickets" => event.available_tickets,
            "booked_tickets" => event.booked_tickets
          }
        )

        service = described_class.new(user.id, event, quantity)
        service.call
      end
    end

    context 'when reservation fails' do
      it 'logs the error' do
        allow(Event::Booking).to receive(:transaction).and_raise(StandardError, 'Reservation failed')
        expect(Rails.logger).to receive(:error).once.with('Error during ticket reservation: Reservation failed')

        service = described_class.new(user.id, event, 2)
        service.call
      end
    end
  end
end
