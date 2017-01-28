require 'test_helper'

class OrganizationsControllerTest < ActionDispatch::IntegrationTest
  test "can I see list of organisations" do
    get "/api/v1/organizations/"
    assert_response :success
    organizations = JSON.parse(response.body)
    assert organizations.length.is_a? Integer
  end


  test "can create an organization" do


    post "/api/v1/organizations",
         params: { organization: { name: "can create" } }

    assert_response :success
  end
end
