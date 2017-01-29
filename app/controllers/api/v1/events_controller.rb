module API::V1
  class Api::V1::EventsController < ApplicationController

    private
    def event_params
      params.require(:event).permit(:message, :hostname, :last_n, :timestamp, :organization_id)
    end

    public

    def create
      @event = Event.new
      @event.update_attributes(event_params)

      if @event.save
        if(event_params.has_key?(:organization_id))
          begin
            @organization = Organization.find(event_params[:organization_id])
            @organization.events << @event
          rescue ActiveRecord::RecordNotFound
            render json: {:error => "organization-not-found"}, :status => 404
          rescue Exception=> e #catch all
            render json: {:error => e}, :status => 400
          end

        end
        if((event_params.has_key?(:organization_id) && @organization) || !event_params.has_key?(:organization_id))
          render  json: {organization: @event.to_json}, status: 201
        end
      else
        render json: {errors: @event.errors}, status: 422
      end

    end

    def show
      begin
        @event = Event.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: {:error => "not-found"}, :status => 404
      rescue Exception=> e #catch all
        render json: {:error => e}, :status => 400
      end

      if (@event)
        render  json: {organization: @event.to_json}, status: 200
      end
    end


    def index
      if(params.key?(:organization_id))
        begin
          organization = Organization.find(params[:organization_id])
          if(params.key?(:last_n))
            if(params.key?(:hostname))
              @events =  organization.events.where(:hostname=>params[:hostname]).order(id: :desc).limit(params[:last_n].to_i)
            else
              @events = organization.events.order(id: :desc).limit(params[:last_n].to_i)
            end
          else
            @events = organization.events
          end

        rescue ActiveRecord::RecordNotFound
          render json: {:error => "organization-not-found"}, :status => 404
        rescue Exception=> e #catch all
          render json: {:error => e}, :status => 400
        end
      else
        @events = Event.all
      end
      if(@events)
        render json: {events: @events.to_json}, status: 200
      end
    end
  end
end