# /spec/requests/api/v1/sessions_spec.rb
require "rails_helper"

describe 'Authentication API', type: :request do
  describe "Get authentication_token" do
    it "on success, returns the user's authentication token" do

      User.delete_all
      user = FactoryGirl.create(:user)

      user_params = {
          "email" => user.email,
          "password" => user.password,
           "grant_type" => "password"
      }


      post "/oauth/token", user_params
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json['access_token']).not_to be_nil
    end
  end
end
