require_relative 'lib/database_connection'
require_relative 'lib/artist_repository'
require_relative 'lib/album_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

# Perform a SQL query on the database and get the result set.

artist_repository = ArtistRepository.new
album_repository = AlbumRepository.new


album_repository.find(3).each do |album|
  puts "#{album.title} - #{album.release_year} - #{album.artist_id}"
end