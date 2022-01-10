FactoryBot.define do
  factory :artist do
    name { Faker::Name.name }
    image { Faker::Internet.url }
    genres { Faker::Music.genre }
    popularity { Faker::Number.number(digits: 2) }
    spotify_url { Faker::Internet.url }
    spotify_id { Faker::Number.number(digits: 10) }
  end
end
