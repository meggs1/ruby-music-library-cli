require 'pry'
class MusicLibraryController
attr_accessor :path

def initialize(path = "./db/mp3s")
    new_object = MusicImporter.new(path)
    new_object.import
end

def call
    input = gets.strip
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    if input != "exit"
        call
    case input
        when "list songs"
           list_songs
        when "list artists"
           list_artists
        when "list genres"
           list_genres
        when "list artist"
           list_songs_by_artist
        when "list genre"
           list_songs_by_genre
        when "play song"
           play_song
        end
    end
end

def list_songs
    sort_list = Song.all.uniq.sort{|a, b| a.name <=>b.name}.each_with_index do |song, i| 
        puts "#{i+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
end

def list_artists
    sort_list = Artist.all.uniq.sort{|a, b| a.name <=>b.name}.each_with_index do |artist, i| 
        puts "#{i+1}. #{artist.name}"
    end
end

def list_genres
    sort_list = Genre.all.uniq.sort{|a, b| a.name <=>b.name}.each_with_index do |genre, i| 
        puts "#{i+1}. #{genre.name}"
    end
end

def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.chomp
    if artist = Artist.find_by_name(input)
      sorted_songs = artist.songs.sort_by {|song| song.name}.each.with_index do |song, i|
        puts "#{i+1}. #{song.name} - #{song.genre.name}"
      end
    end
end

def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.chomp
    if genre = Genre.find_by_name(input)
        sorted_songs = genre.songs.sort_by {|song| song.name}.each.with_index do |song, i|
          puts "#{i+1}. #{song.artist.name} - #{song.name}"
        end
    end
end

def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i
    if input >= 1 && input <= Song.all.uniq.length 
        song_array = Song.all.uniq.sort{|a, b| a.name <=> b.name}
        song = song_array[input - 1]
        puts "Playing #{song.name} by #{song.artist.name}"
    end
end


end

