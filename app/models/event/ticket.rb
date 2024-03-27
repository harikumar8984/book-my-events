class Event::Ticket < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :event

  enum status: { available: 0, booked: 1}
end