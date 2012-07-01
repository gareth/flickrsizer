require 'sinatra'
require './lib/flickrsizer'

get '/' do

  begin
    raise APIError, "Missing 'id' parameter" unless params[:id]
  rescue APIError => e
    [422, {}, [e.to_s]]
  rescue => e
    [500, {}, [e.to_s]]
  end
end

class APIError < StandardError; end