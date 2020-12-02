class MusicImporter
attr_accessor :path

def initialize(path)
  @path = path
end

def files
  files = []
  Dir.glob("#{path}/*.mp3").collect do |file|
    files << file.gsub("#{path}/", "")
  end
  files
end
    
def import
  self.files.each {|filename| Song.create_from_filename(filename)}
end

end