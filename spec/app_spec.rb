require_relative '../app'

RSpec.describe Application do
  let(:database_name) { 'music_library_test' }
  let(:io) { double('IO') }
  let(:album_repository) { double('AlbumRepository') }
  let(:artist_repository) { double('ArtistRepository') }

  subject(:app) { Application.new(database_name, io, album_repository, artist_repository) }

  describe '#run' do
    context 'when choice is 1' do
      let(:albums) { [double('Album', id: 1, title: 'Doolittle', release_year: 1989)] }

      before do
        allow(io).to receive(:puts)
        allow(io).to receive(:print)
        allow(io).to receive(:gets).and_return("1\n")

        allow(album_repository).to receive(:all).and_return(albums)
      end

      it 'lists all albums' do
        expect(io).to receive(:puts).with("Welcome to the music library manager!\n\n")
        expect(io).to receive(:puts).with("What would you like to do?")
        expect(io).to receive(:puts).with(" 1 - List all albums")
        expect(io).to receive(:puts).with(" 2 - List all artists\n\n")
        expect(io).to receive(:print).with("Enter your choice: ")
        expect(io).to receive(:puts).with("\nHere is the list of albums:")
        expect(io).to receive(:puts).with(" * 1 - Doolittle - 1989")

        app.run
      end
    end

    context 'when choice is 2' do
      let(:artists) { [double('Artist', id: 1, name: 'The Beatles', genre: 'Rock')] }

      before do
        allow(io).to receive(:puts)
        allow(io).to receive(:print)
        allow(io).to receive(:gets).and_return("2\n")

        allow(artist_repository).to receive(:all).and_return(artists)
      end

      it 'lists all artists' do
        expect(io).to receive(:puts).with("Welcome to the music library manager!\n\n")
        expect(io).to receive(:puts).with("What would you like to do?")
        expect(io).to receive(:puts).with(" 1 - List all albums")
        expect(io).to receive(:puts).with(" 2 - List all artists\n\n")
        expect(io).to receive(:print).with("Enter your choice: ")
        expect(io).to receive(:puts).with("\nHere is the list of artists:")
        expect(io).to receive(:puts).with(" * 1 - The Beatles - Rock")

        app.run
      end
    end

    context 'when choice is invalid' do
      before do
        allow(io).to receive(:puts)
        allow(io).to receive(:print)
        allow(io).to receive(:gets).and_return("3\n")
      end

      it 'displays an error message' do
        expect(io).to receive(:puts).with("Welcome to the music library manager!\n\n")
        expect(io).to receive(:puts).with("What would you like to do?")
        expect(io).to receive(:puts).with(" 1 - List all albums")
        expect(io).to receive(:puts).with(" 2 - List all artists\n\n")
        expect(io).to receive(:print).with("Enter your choice: ")
        expect(io).to receive(:puts).with("\nInvalid choice. Please try again.")

        app.run
      end
    end
  end
end
