require "rails_helper"
require 'factory_girl_rails'


RSpec.describe Service, :type => :model do

  it "create services and orders by name" do
  	Service.delete_all
    pizzeria = Service.create!(name: "Pizzeria")
    shoes_store = Service.create!(name: "Zapateria")
    expect(Service.order_by(:name => 'asc')).to eq([pizzeria, shoes_store])
  end


  it "add services to users and orders by name" do
  	User.delete_all
    ronald = User.create!(email: "ronalanto03@gmail.com", password: "12345678")
    lola = User.create!(email: "lola@gmail.com", password: "12345678")

  	Service.delete_all
    pizzeria_lola = lola.services.create!(name: "PizzeriaLola")
    shoes_store_lola = lola.services.create!(name: "ZapateriaLola")

    pizzeria_ronald = ronald.services.create!(name: "PizzeriaRonald")
    shoes_store_ronald = ronald.services.create!(name: "ZapateriaRonald")

    expect(Service.order_by(:name => 'asc').to_a).to eq([pizzeria_lola, pizzeria_ronald, shoes_store_lola, shoes_store_ronald])

    expect(lola.services.order_by(:name => 'asc').to_a).to eq([pizzeria_lola, shoes_store_lola])

    expect(ronald.services.order_by(:name => 'asc').to_a).to eq([pizzeria_ronald, shoes_store_ronald])

  end
end
