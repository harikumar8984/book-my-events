# frozen_string_literal: true

require 'test_helper'


class Event::TicketsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get event_tickets_new_url
    assert_response :success
  end

  test 'should get create' do
    get event_tickets_create_url
    assert_response :success
  end
end

