require 'album_repository'

RSpec.describe AlbumRepository do
  def reset_albums_table
    seed_sql = File.read('spec/seeds_albums.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_albums_table
  end

  it "returns two albums" do
    repo = AlbumRepository.new

    albums = repo.all
    expect(albums.length).to eq 2 # => 2
    expect(albums.first.title).to eq "Bossanova" # => 'Bossanova'
    expect(albums.first.release_year).to eq '1999' # => '1999'
    expect(albums.first.artist_id).to eq '1' # => '1'
  end

  it 'returns the album with the specified ID' do
    repo = AlbumRepository.new
    album = repo.find(2)

    #expect(album.first.id).to eq(1)
    expect(album.first.title).to eq('Surfer Rosa')
    expect(album.first.release_year).to eq('2001')
    expect(album.first.artist_id).to eq("1")
  end
end