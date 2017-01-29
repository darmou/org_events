require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest


  def get_last_created_org_id
    get "/api/v1/organizations"
    resp = JSON.parse(response.body)
    organizations = JSON.parse(resp["organizations"])
    organizations.last['id']
  end

  def before_setup
    super
    post "/api/v1/organizations",
         params: { organization: { name: "can create org" } }

    5.times { |i|
      post "/api/v1/events",
           params: { event: { message: "can create event " + i.to_s, hostname: "special_hostname#{i % 2}", organization_id: get_last_created_org_id } }

    }
  end

  test "can I see list of events" do
    get "/api/v1/events/"
    assert_response :success
    resp = JSON.parse(response.body)
    events = JSON.parse(resp["events"])
    assert events.length.is_a? Integer
  end

  test "can I see list of events for an organization" do
    #get the id of the org we created in setup

    get "/api/v1/events/?organization_id=" + get_last_created_org_id.to_s
    assert_response :success
    resp = JSON.parse(response.body)
    events = JSON.parse(resp["events"])
    assert events.length == 5
    assert events.first["message"] == "can create event 0"
  end

  test "can see the last 2 events" do
    get"/api/v1/events/?organization_id=" + get_last_created_org_id.to_s + "&last_n=2"
    assert_response :success
    resp = JSON.parse(response.body)
    events = JSON.parse(resp["events"])
    assert events.length == 2
    assert events.last["message"] == "can create event 3"
  end

  test "can see the last 2 events for a hostname" do
    get"/api/v1/events/?organization_id=" + get_last_created_org_id.to_s + "&last_n=2&hostname=special_hostname0"
    assert_response :success
    resp = JSON.parse(response.body)
    events = JSON.parse(resp["events"])
    assert events.length == 2
    assert events.last["message"] == "can create event 2"
  end

  test "can create an event" do


    post "/api/v1/events",
         params: { event: { message: "can create", hostname: "localhost" } }

    assert_response :success
  end
end
