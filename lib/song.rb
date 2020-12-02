class Song < MusicImporter

attr_accessor :name
attr_reader :artist, :genre
@@all = []

def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist unless artist == nil
    self.genre = genre unless genre == nil
end 

def self.all
    @@all
end

def self.destroy_all
    @@all.clear
end

def save
    @@all << self
end

def self.create(name)
    song = self.new(name)
    song.save
    song
end

def artist=(artist)
    @artist = artist
    artist.add_song(self)
end

def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
end

def self.find_by_name(name)
    @@all.find {|song| song.name == name}
end

def self.find_or_create_by_name(name)
    # if self.find_by_name(name)
    #     self.find_by_name(name)
    # else
    #     self.create(name)
    # end   
    #refactored
    self.find_by_name(name) || self.create(name)
end

def self.new_from_filename(filename)
    # song_name = filename.split(" - ")[1]
    # artist_name = filename.split(" - ")[0]
    # genre_name = filename.split(" - ")[2].chomp(".mp3")
    # refactored
    filename = filename.split(" - ")
  
    song = self.find_or_create_by_name(filename[1])
    song.artist = Artist.find_or_create_by_name(filename[0])
    song.genre = Genre.find_or_create_by_name(filename[2].chomp(".mp3"))

    song
end

def self.create_from_filename(filename)
    @@all << self.new_from_filename(filename)
end

end