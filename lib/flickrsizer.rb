require 'flickraw-cached'
require 'open-uri'
require 'RMagick'

require 'digest/sha1'

module Flickrsizer

  WIDTH = 400
  HEIGHT = 300

  # Selects the smallest photo larger than our target size
  def self.source_url photo_id
    sizes = flickr.photos.getSizes(photo_id: photo_id).sort_by { |s| s.width.to_i * s.height.to_i }
    suitable_size = sizes.detect { |s| s.width.to_i >= WIDTH && s.height.to_i >= HEIGHT }
    suitable_size.source
  end

  def self.file photo_id, text = nil
    cache_path = file_cache(photo_id, text)
    file_path = "tmp/%s" % cache_path
    unless File.exists? file_path
      image = Magick::Image.read(source_url(photo_id)).first
      image.scale!(WIDTH, HEIGHT)

      if text
        txt = Magick::Draw.new
        image.annotate(txt, 0,0,0,0, text){
          txt.gravity = Magick::SouthGravity
          txt.font_weight = Magick::BoldWeight
          txt.pointsize = 20
          txt.stroke = '#000000'
          txt.fill = '#ffffff'
        }
      end

      image.write(file_path)
    end
    cache_path
  end

  private
  def self.flickr
    return @flickr if @flickr
    FlickRaw.api_key = ENV["FLICKR_API_KEY"]
    FlickRaw.shared_secret = ENV["FLICKR_API_SECRET"]
    @flickr = FlickRaw::Flickr.new
  end

  def self.file_cache photo_id, text = nil
    hash = Digest::SHA1.hexdigest(text) if text
    "photo/%s%s.jpg" % [photo_id, (".#{hash}" if hash)]
  end
end