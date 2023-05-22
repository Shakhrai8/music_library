require_relative './album'

class AlbumRepository
  def all
    albums = []
    #defining sql query string
    sql = 'SELECT id, title, release_year, artist_id FROM albums;'
    #executes sql query and passes sql string and an empty array as an argument
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      #for each record it creates a new instance and assigns corresponding atributes
      album = Album.new

      album.id = record['id']
      album.title = record['title']
      album.release_year = record['release_year']
      album.artist_id = record['artist_id']

      albums << album
    end

    return albums
  end
end