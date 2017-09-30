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

  describe "New service" do
    it "on success, a new service is created" do

      Service.destroy_all
      json_content = File.read(File.dirname(__FILE__) + '/services_json/service1.json')

      post "/api/v1/services", json_content
      expect(response.status).to eq(200), "#{(response.body)['error']}"
      id = JSON.parse(response.body)['id']

      begin
        service = Service.find(id)    
      rescue Mongoid::Errors::DocumentNotFound => e
        service = nil
      end

      expect(service).not_to be(nil)

      expect(service.name).to eq(JSON.parse(json_content)['name'])
      expect(service.description).to eq(JSON.parse(json_content)['description'])
      expect(service.category).to eq(JSON.parse(json_content)['category'])
      expect(service.status.to_s).to eq(JSON.parse(json_content)['status'])
      expect(service.coordinates[0].to_s).to eq(JSON.parse(json_content)['coordinates'][0])
      expect(service.coordinates[1].to_s).to eq(JSON.parse(json_content)['coordinates'][1])
    end
  end
end
