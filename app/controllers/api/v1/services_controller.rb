class Api::V1::ServicesController < ApplicationController
  before_action :doorkeeper_authorize!, except: [:index, :show, :create]

  respond_to :json

  #Get all services(This method should not be exposed to the users in a production environment)
  def index
    @services = Service.all
    # respond_with @services

    render :status => 200,
           :json => { :success => true,
                      :data => @services }
  end

  #Get a service with a given id
  def show
  	begin
      service = Service.find(user_params[:id])
  	rescue Mongoid::Errors::DocumentNotFound => e
      service = nil  		
    end

    if service
      render status: 200,
        json: {:data => service}
      return
    else
      warden.custom_failure!
      render json: { success: false, error: 'Service not found' }, status: 404
    end
  end

  def create
    service_information = request.raw_post
    data_parsed = JSON.parse(service_information)

    service_hash = json_to_service_validator(data_parsed)
    new_service = service_hash[:data]
    if(new_service and new_service.save)
      render status: 200,
           json: {id: new_service.id}
    else
      if(new_service)
        errors = new_service.errors.full_messages.to_sentence
      else
        errors = quiz_hash[:errors]
      end
      render status: 405,
           json: {error: errors}
    end
 
  end

 private
  def user_params
    params.permit(:id)
  end


  # It validates the json object and returns the corresponging service
  def json_to_service_validator(json)
    if(json.count  == 5 and
       json['name'] and
       json['description'] and
       json['category'] and
       json['status'] and
       json['coordinates'] and
       json['coordinates'].count  == 2)
      
      service = Service.new (json)
      retval = {:data => service}
    else
      return {:errors => "The json object to create a service is wrong"}
    end
    return retval
  end

end
