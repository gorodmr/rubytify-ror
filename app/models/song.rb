class Song < ApplicationRecord

  #self.primary_key = 'spotify_id'
  belongs_to :album

  validates :album, presence:true
  validates :name, presence:true
  validates :preview_url, presence:true
  validates :spotify_url, presence:true
  validates :duration_ms, presence:true
  validates :explicit, inclusion: { in: [true, false]}
  validates :spotify_id, presence:true

end
