class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :albums do |t|
      t.string :name
      t.string :image
      t.string :spotify_url
      t.integer :total_tracks
      t.string :spotify_id
      t.references :artist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
