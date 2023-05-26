require_relative './lib/album_repository'
require_relative './lib/artist_repository'
require_relative './lib/database_connection'

class Application
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    @io.puts "Welcome to the music library manager!\n\n"
    @io.puts "What would you like to do?"
    @io.puts " 1 - List all albums"
    @io.puts " 2 - List all artists\n\n"
    @io.print "Enter your choice: "

    choice = @io.gets.chomp.to_i

    case choice
    when 1
      @io.puts "\nHere is the list of albums:"
      albums = @album_repository.all
      albums.each do |album|
        @io.puts " * #{album.id} - #{album.title} - #{album.release_year}"
      end
    when 2
      @io.puts "\nHere is the list of artists:"
      artists = @artist_repository.all
      artists.each do |artist|
        @io.puts " * #{artist.id} - #{artist.name} - #{artist.genre}"
      end
    else
      @io.puts "\nInvalid choice. Please try again."
    end
  end
end

if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
  )
  app.run
end
