require 'test_helper'


class OrganizationTest < ActiveSupport::TestCase

  test "organasation must have a name" do
    organsation = Organization.new
    assert_not organsation.save
  end
end