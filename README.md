# Booking Ticket Application

This is a booking ticket application that allows users to book tickets for events.

## Getting Started

To get started with the application, follow these steps:

### Prerequisites

- Ruby 3.2.2 installed on your machine
- PostgreSQL installed and running on your machine
- Redis installed and running on your machine

### Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/your_username/book-my-events.git

2. Install dependencies:
   ```bash
   bundle install

3. Create environment file:
   ```bash
   cp .env.example .env
   vi .env

4. Create and migrate the database:
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
5. Start Rails server:
   ```bash
	 rails server

6. Start Sidekiq:
	 ```bash
	 bundle exec sidekiq

Application up and running on http://localhost:3000 in your web browser.
