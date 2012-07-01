require 'flickraw-cached'

module Flickrsizer

  WIDTH = 400
  HEIGHT = 300

  # Selects the smallest photo larger than our target size
  def self.source_url photo_id
    sizes = flickr.photos.getSizes(photo_id: photo_id).sort_by { |s| s.width.to_i * s.height.to_i }
    suitable_size = sizes.detect { |s| s.width.to_i >= WIDTH && s.height.to_i >= HEIGHT }
    suitable_size.source
  end

  def self.flickr
    return @flickr if @flickr
    FlickRaw.api_key = ENV["FLICKR_API_KEY"]
    FlickRaw.shared_secret = ENV["FLICKR_API_SECRET"]
    @flickr = FlickRaw::Flickr.new
  end
end