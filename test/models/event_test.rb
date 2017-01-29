require 'test_helper'

describe Event do

  it "should save with all attributes" do
    event = Event.new
    event.message = "Test Message"
    event.hostname = "localhost"
    event.timestamp = Time.now.to_i
    assert event.save
  end
end