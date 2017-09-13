require "rails_helper"

RSpec.describe User, :type => :model do
  it "orders by email" do

  	User.delete_all
    ronald = User.create!(email: "ronalanto03@gmail.com", password: "12345678")
    lola = User.create!(email: "lola@gmail.com", password: "12345678")
    expect(User.order_by(:email => 'asc')).to eq([lola, ronald])
  end
end