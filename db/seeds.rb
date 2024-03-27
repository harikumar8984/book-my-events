# Clear existing events before seeding
Event.destroy_all

# Generate new events using FactoryBot
events_count = 20
events = FactoryBot.create_list(:event, events_count)

# Generate tickets for each event using a service class
events.each do |event|
  Events::Tickets::GenerateService.call(event)
end
