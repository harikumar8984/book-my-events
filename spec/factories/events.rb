# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    sequence(:name) { |n| "Event #{n}" }
    description { 'An amazing event' }
    location { 'Event Location' }
    event_at { Date.today + rand(1..30).days } # Random date within 30 days from today
    total_tickets { rand(50..200) } # Random total tickets between 50 and 200
  end
end
