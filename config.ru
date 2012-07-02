require 'sinatra'

require './app.rb'

use Rack::Static, :urls => ["/photo"], :root => "tmp"
run Sinatra::Application