require 'test_helper'

class OrganizationsControllerTest < ActionDispatch::IntegrationTest
  let(:organization) { organizations :one }

  it "gets index" do
    get  "/api/v1/organizations"
    value(response).must_be :success?
  end

  it "creates organization" do
    expect {
      post  "/api/v1/organizations", params: { organization: { name: "test org" } }
    }.must_change "Organization.count"

    value(response.status).must_equal 201
  end

  it "shows organization" do
    get  "/api/v1/organizations/" + organization.id.to_s
    value(response).must_be :success?
  end

  it "destroys organization" do
    expect {
      delete "/api/v1/organizations/" + organization.id.to_s
    }.must_change "Organization.count", -1

    value(response.status).must_equal 204
  end
end
