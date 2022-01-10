require 'rails_helper'

RSpec.describe Album, type: :model do
  describe "Validations" do
    it "validate presence of requerid fields" do
      should validate_presence_of(:name)
      should validate_presence_of(:image)
      should validate_presence_of(:spotify_url)
      should validate_presence_of(:total_tracks)
      should validate_presence_of(:spotify_id)
    end

    it "validate relations" do
      should have_many(:songs)
    end
  end
end
