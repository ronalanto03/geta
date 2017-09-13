class Api::V1::RegistrationsController  < ApplicationController

  # skip_before_filter :verify_authenticity_token
  respond_to :json

  def create

    user = User.new(user_params)

    if user.save
      render status: 201,
        json: {email:user_params[:email]}
      return
    else
      warden.custom_failure!
      render json: { success: false, error: user.errors }, status: 422
    end

  end

 private
  def user_params
    params.permit(:email, :password)
  end

end