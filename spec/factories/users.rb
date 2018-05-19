FactoryBot.define do
  factory :user, class: User do
    name { generate(:name) } 
    email { generate(:email) } 
    activated true
    password 'hayheyatthebay'
  end

  sequence :name do |n|
    "user_#{n}"
  end

  sequence :email do |n|
    "user_#{n}@#{%w[comcast.net gmail.com yahoo.com].sample}"
  end

  trait :unregistered do
    activated false
  end

  factory :unregistered_user, traits: [:unregistered]
end
