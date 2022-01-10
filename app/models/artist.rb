class Artist < ApplicationRecord

  #self.primary_key = 'spotify_id'

  has_many :albums
  validates :name, presence:true
  validates :image, presence:true
  validates :genres, presence:true
  validates :popularity, presence:true
  validates :spotify_url, presence:true
  validates :spotify_id, presence:true

=begin
  def initialize(albums, name, image, genres, popularity, spotify_url, spotify_id)
    @albums = albums
    @name = name
    @image = image
    @genres = genres
    @ppopularity = popularity
    @sspotify_url = spotify_url
    @spspotify_id = spotify_id
  end
=end
end
