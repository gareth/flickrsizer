require_relative '../app'

require 'rspec'
require 'rack/test'

set :environment, :test

describe 'Flickrsizer App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "exists" do
    true
  end
end