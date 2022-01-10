require 'json'
class ArtistController < ApplicationController

  #/api/v1/artists
  def getAllArtist
    @artists = Artist.order(popularity: :desc)
    #debugger
    render json: {:data =>@artists}.to_json, status: :ok

  end

end