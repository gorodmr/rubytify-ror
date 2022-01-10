require "rails_helper"

RSpec.describe "Artist endpoints", type: :request do

  describe "GET /api/v1/artists" do
    let!(:artists) {create_list(:artist, 2, name: 'Artic Monkeys')}
    it "should return OK" do
      get '/api/v1/artists'
      payload = JSON.parse(response.body)

      expect(payload).not_to be_empty
    end
  end

  describe "GET /api/v1/artists when there is artist data in the database" do

    let!(:artists) {create_list(:artist, 2, name: 'Artic Monkeys')}

    it "should return all artists data" do
      get '/api/v1/artists'
      payload = JSON.parse(response.body)
      puts "Payload #{payload}"
      #debugger
      expect(payload).to_not be_empty
      expect(response).to have_http_status(200)
      expect(payload["data"].size).to eq(artists.size)
    end
  end

end

