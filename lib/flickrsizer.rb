require 'flickraw-cached'
require 'open-uri'

module Flickrsizer

  WIDTH = 400
  HEIGHT = 300

  # Selects the smallest photo larger than our target size
  def self.source_url photo_id
    sizes = flickr.photos.getSizes(photo_id: photo_id).sort_by { |s| s.width.to_i * s.height.to_i }
    suitable_size = sizes.detect { |s| s.width.to_i >= WIDTH && s.height.to_i >= HEIGHT }
    suitable_size.source
  end

  def self.file photo_id
    file_path = file_cache(photo_id)
    unless File.exists? file_path
      source = open(source_url(photo_id)).read
      File.open(file_path, "w") do |f|
        f << source
      end
    end
    File.open(file_path)
  end

  private
  def self.flickr
    return @flickr if @flickr
    FlickRaw.api_key = ENV["FLICKR_API_KEY"]
    FlickRaw.shared_secret = ENV["FLICKR_API_SECRET"]
    @flickr = FlickRaw::Flickr.new
  end

  def self.file_cache photo_id
    "tmp/photo/%s.jpg" % photo_id
  end
end