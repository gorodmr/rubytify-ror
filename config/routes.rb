Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/health', to: 'health#health'

  get '/api/v1/artists', to: 'artist#getAllArtist'
  get '/api/v1/artists/:id/albums', to: 'album#getAlbumByArtistId'
  get '/api/v1/albums/:id/songs', to: 'song#getSongsByAlbumId'
  get '/api/v1/genres/:genre_name/random_song', to: 'song#getSongByGenre'
end
