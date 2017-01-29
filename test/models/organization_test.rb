require "test_helper"

describe Organization do
  it "should have a name" do
    organization = Organization.new
    assert_not organization.save
  end
end