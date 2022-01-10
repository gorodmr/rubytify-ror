require 'rails_helper'

RSpec.describe Song, type: :model do
  describe "Validations" do
    it "validate presence of requerid fields" do
      should validate_presence_of(:name)
      should validate_presence_of(:preview_url)
      should validate_presence_of(:spotify_url)
      should validate_presence_of(:duration_ms)
      should validate_presence_of(:spotify_id)
    end
  end
end
