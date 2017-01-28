require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def before_setup
    super
    # ... stuff to do before setup is run
    post "/api/v1/organizations",
         params: { organization: { name: "can create" } }

    post "/api/v1/events",
        params: { event: { message: "can create", hostname: "localhost", organization_id: 1 } }
  end

  test "can I see list of events" do
    get "/api/v1/events/"
    assert_response :success
    events = JSON.parse(response.body)
    assert events.length.is_a? Integer
  end

  test "can I see list of events for an organization" do
    get "/api/v1/events/?organization_id=1"
    assert_response :success
    events = JSON.parse(response.body)
    assert events.length.is_a? Integer
  end

  test "can create an event" do


    post "/api/v1/events",
         params: { event: { message: "can create", hostname: "localhost" } }

    assert_response :success
  end
end
