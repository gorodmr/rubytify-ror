FactoryBot.define do
  factory :album do
    name { Faker::Name.name }
    image { Faker::Internet.url }
    spotify_url { Faker::Internet.url }
    total_tracks { Faker::Number.number(digits: 3)  }
    spotify_id { Faker::Number.number(digits: 10)  }
    artist
  end
end
