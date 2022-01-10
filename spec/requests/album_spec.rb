require "rails_helper"

RSpec.describe "Album endpoints", type: :request do
  describe "GET /api/v1/artists/:id/albums All albums from artist id" do

    let!(:albums) {create_list(:album, 2)}

    it "should return all albums from artist id" do
      get '/api/v1/artists/1/albums'
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(response).to have_http_status(200)
      expect(payload.size).to eq(1)
    end
  end
end
