desc "Loads the following artist list from a artist.yml file and import the specified artists, all of their albums and songs"
task :loadartists => :environment do
  require 'yaml'
  config = YAML.load_file("#{Rails.root}/artists.yml")
  config.each do |key, value|
    puts key
    if(key == 'artists')
      @artistsList = value
    end
  end

  require "uri"
  require "net/http"
  require "json"

  def login

    url = URI("https://accounts.spotify.com/api/token")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = "application/x-www-form-urlencoded"
    request["Authorization"] = "Basic ZGYwMTJjYjNjYzI5NDUzNzkwODY4ZWZiMzk0NmU0Yjg6N2M0NTcxYzFjMDJkNGQ0M2FmMzY4YWNlM2VkZmIyMzA="
    request["Cookie"] = "__Host-device_id=AQDQ-b1f_MSI1qAymW_PjzVRDW0aD6LRjURTzp6-EpeA381MLiLqGUq-S9fD0bNVSYPAAH4AVEqEgp2NM9Os9GQke4sXi_4ZXaA; sp_tr=false"
    request.body = "grant_type=client_credentials"

    response = https.request(request)
    token = response.read_body
    payload = JSON.parse(token)
    payload["access_token"]
  end

  token = login
  puts token

  def getArtists(token, artistName)
    url = URI("https://api.spotify.com/v1/search?q=artist:#{artistName}&type=artist&limit=1")

    puts url
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["Content-Type"] = "application/json"
    request["Authorization"] = "Bearer #{token}"

    response = https.request(request)
    response.read_body
  end

  def getAlbumsByArtist(token, artistId)
    url = URI("https://api.spotify.com/v1/artists/#{artistId}/albums")

    puts url
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["Content-Type"] = "application/json"
    request["Authorization"] = "Bearer #{token}"

    response = https.request(request)
    JSON.parse(response.read_body)["items"]

  end

  def getSongsByAlbum(token, albumId)
    url = URI("https://api.spotify.com/v1/albums/#{albumId}/tracks")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["Content-Type"] = "application/json"
    request["Authorization"] = "Bearer #{token}"

    response = https.request(request)
    JSON.parse(response.read_body)["items"]
  end

  def createSongsByAlbum(token, album)
    songs = getSongsByAlbum(token, album.spotify_id)

    unless songs.blank?
      songs.each { |i|
        Song.create(album: album, name: i["name"], preview_url: i["preview_url"], spotify_url: i["href"],
                    duration_ms: i["duration_ms"], explicit: i["explicit"], spotify_id: i["id"])
      }
    end
  end

  def createAlbums(token, artist)
    albums = getAlbumsByArtist(token, artist.spotify_id)

    unless albums.blank?
      albums.each { |i|
        album = Album.create(artist: artist, name: i["name"], image: i["images"], spotify_url: i["href"],
                             total_tracks: i["total_tracks"], spotify_id: i["id"])

        createSongsByAlbum(token, album)
      }
    end
  end

  @artistsList.each { |i|
    artistJson = JSON.parse(getArtists(token, i))
    artist = artistJson["artists"]

    unless artist["items"].blank?
      puts "entro"
      artistItem = artist["items"][0]
      artist = Artist.create(name: artistItem["name"], image: artistItem["images"], genres: artistItem["genres"],
                    popularity: artistItem["popularity"], spotify_url: artistItem["external_urls"]["spotify"],
                    spotify_id: artistItem["id"])
      createAlbums(token, artist)
    end
  }
end