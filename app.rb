require 'sinatra'
require './lib/flickrsizer'

get %r{/(?<id>\d+)} do

  begin
    raise APIError, "Missing 'id' parameter" unless params[:id]

    if path = Flickrsizer.file(params[:id], params[:text])
      content_type "text/plain"
      url(path)
    else
      raise APIError, "Unknown error retrieving photo #{params[:id]}"
    end

  rescue APIError => e
    [422, {}, [e.to_s]]
  rescue => e
    [500, {"Content-Type" => "text/plain"}, [e.to_s]]
  end
end

class APIError < StandardError; end