module API::V1
  class Api::V1::OrganizationsController < ApplicationController

    private
      def test_for_org params
        begin
          @organization = Organization.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          render json: {:error => "not-found"}, :status => 404
        rescue Exception=> e #catch all
          render json: {:error => e}, :status => 400
        end
        @organization
      end

    public

    def new
    end

    def create
      @organization = Organization.new
      @organization.update_attributes(params)

      if @organization.save
        render  json: {organization: @organization.to_json}, status: 200
      else
        render json: {errors: @organization.errors}, status: 422
      end
    end

    def show
      @organization = test_for_org params

      if (@organization)
        render  json: {organization: @organization.to_json}, status: 200
      end
    end

    def index
      @organizations = Organization.all
      render json: {organizations: @organizations.to_json}, status: 200
    end

    def destroy
      @organization = test_for_org params

      if (@organization)
        id = @organization.id
        @organization.destroy
        render  json: {message: "organizanion with id #{id} destroyed".to_json}, status: 200
      end
    end
  end
end