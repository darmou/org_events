require 'test_helper'


class OrganizationTest < ActiveSupport::TestCase

  test "Organization must have a name" do
    organization = Organization.new
    assert_not organization.save
  end
end