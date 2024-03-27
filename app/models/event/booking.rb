class Event::Booking < ApplicationRecord
  include AvailabilityValidatable	

  belongs_to :user
  belongs_to :event

  validates :quantity, presence: true, numericality: { greater_than: 0 }

  enum status: { pending: 0, booked: 1, paid: 2}
end
