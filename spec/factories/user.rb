FactoryGirl.define do
  factory :user, :class => 'User' do
    email { Faker::Internet.email }
    password "password"
    confirmed_at Date.today
  end
end