FactoryGirl.define do
  factory :service, :class => 'Service' do
    name { Faker::Company.name }
    description { Faker::Lorem.paragraphs.to_s }
    category {["clothes", "food" ].sample}
    status {rand(2) == 1}
    coordinates {ServicesHelper::random_location_from_given_pos([8.596765, -71.147219] , rand(0.0...5000))}
    # coordinates {[Faker::Address.latitude.to_f, Faker::Address.longitude.to_f]}
  end
end

