# /spec/requests/api/v1/sessions_spec.rb
require "rails_helper"

describe 'Authentication API', type: :request do
  describe "Get authentication_token" do
    it "on success, returns the user's authentication token" do

      User.delete_all

      user_params = {
          "email" => 'ronalanto03@gmail.com',
          "password" => '19911991'
      }


      post "/api/v1/registrations", user_params

      expect(response.status).to eq(201), "#{response.body}"

      json = JSON.parse(response.body)
      expect(json['email']).to eq('ronalanto03@gmail.com')
    end
  end
end
