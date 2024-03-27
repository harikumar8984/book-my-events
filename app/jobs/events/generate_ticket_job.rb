class Events::GenerateTicketJob < ApplicationJob
  queue_as :default

  def perform(event)
    Events::Tickets::GenerateService.call(event)
  end
end
