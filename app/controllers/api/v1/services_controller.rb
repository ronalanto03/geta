class Api::V1::ServicesController < ApplicationController
  before_action :doorkeeper_authorize!, except: [:index, :show]

  respond_to :json

  def index
    @services = Service.all
    # respond_with @services

    render :status => 200,
           :json => { :success => true,
                      :data => @services }
  end

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

 private
  def user_params
    params.permit(:id)
  end

end
