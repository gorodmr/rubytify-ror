class Album < ApplicationRecord
  #self.primary_key = 'spotify_id'

  belongs_to :artist
  has_many :songs
  validates :artist, presence:true
  validates :name, presence:true
  validates :image, presence:true
  validates :spotify_url, presence:true
  validates :total_tracks, presence:true
  validates :spotify_id, presence:true

=begin
  def initialize(artist, name, image, genres, popularity, spotify_url, spotify_id)
    @albums = albums
    @name = name
    @image = image
    @genres = genres
    @popularity = popularity
    @spotify_url = spotify_url
    @spotify_id = spotify_id
  end
=end
end
