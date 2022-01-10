require 'json'
class SongController < ApplicationController

  #/api/v1/albums/:id/songs
  def getSongsByAlbumId
    @songs = Song.where("album_id = :album_id", {album_id: params[:id]})
    render json: {:data => @songs}.to_json, status: :ok
  end

  #/api/v1/genres/:genre_name/random_song
  def getSongByGenre
    @song = Song.joins(album: [ :artist]).where('artist.genres = ?', params[:genre_name])
    render json: {:data => @song}.to_json, status: :ok
  end
end

