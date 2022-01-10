require 'json'
class AlbumController < ApplicationController

  #/api/v1/artists/{id}/albums
  def getAlbumByArtistId
    #debugger
    @albums = Album.where("artist_id = :artist_id", {artist_id: params[:id]})
    #debugger
    render json: {:data =>@albums}.to_json, status: :ok
  end
end
