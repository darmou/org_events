module API::V1
  class Api::V1::OrganizationsController < ApplicationController

    private
      def test_for_type id, type
        begin
          type_obj = type.constantize.find(id)
        rescue ActiveRecord::RecordNotFound
          render json: {:error => type.downcase + "-not-found"}, :status => 404
        rescue Exception=> e #catch all
          render json: {:error => e}, :status => 400
        end
        type_obj
      end

    # Only allow a trusted parameter "white list" through.
    def organization_params
      params.require(:organization).permit(:name)
    end

    public

    def new
    end

    def create
      @organization = Organization.new
      @organization.update_attributes(organization_params)

      if @organization.save
        render  json: {organization: @organization.to_json}, status: 201
      else
        render json: {errors: @organization.errors}, status: 422
      end
    end

    def show
      @organization =  test_for_type params[:id], "Organization"

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
        render  json: {message: "organizanion with id #{id} destroyed".to_json}, status: 204
      end
    end
  end
end