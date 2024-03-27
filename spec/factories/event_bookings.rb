# frozen_string_literal: true

FactoryBot.define do
  factory :event_booking, class: 'Event::Booking' do
    event
    user
    quantity { 1 }
    status { :pending }
  end
end
