# /spec/requests/api/v1/sessions_spec.rb
require "rails_helper"

describe 'Services API', type: :request do
  # describe "Get all Services" do
  #   it "on success, returns all the Services" do

  #     Service.delete_all
  #     new_services = Array.new(100) {FactoryGirl.create(:service)}
  #     new_services.each{|val| val.save!}

  #     user_params = {
  #         "category" => 'food'
  #     }


  #     get "/api/v1/services", user_params

  #     expect(response.status).to eq(200), "#{response.body}"

  #     json = JSON.parse(response.body)
  #     p json
  #     service_array = json['data'].map { |val| Service.new val}

  #     expect(service_array).to eq(new_services)
  #   end
  # end

  describe "Get a service" do
    it "on success, returns a service" do

      Service.delete_all
      new_service = FactoryGirl.create(:service)

      get "/api/v1/services/"+new_service.id.to_s#, user_params
      expect(response.status).to eq(200), "#{JSON.parse(response.body)['error']}"
      json = JSON.parse(response.body)
      got_service = Service.new json['data']
      expect(new_service).to eq(got_service)


      get "/api/v1/services/"+new_service.id.to_s + "r"
      expect(response.status).to eq(404), "#{JSON.parse(response.body)['error']}"
    end
  end

end
