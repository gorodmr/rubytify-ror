FactoryBot.define do
  factory :song do
    name { Faker::Name.name }
    spotify_url { Faker::Internet.url }
    preview_url { Faker::Internet.url }
    duration_ms { Faker::Number.number(digits: 10)  }
    explicit {
      r = rand(0..1)
      if r==0
        false
      else
        true
      end
    }
    spotify_id { Faker::Number.number(digits: 10)  }
    album
  end
end
