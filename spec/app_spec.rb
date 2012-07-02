require_relative 'spec_helper'
require_relative '../app'

require 'rspec'
require 'rack/test'

set :environment, :test

describe 'Flickrsizer App' do
  use_vcr_cassette
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "requires an id parameter" do
    get '/'

    last_response.should be_a_client_error
  end

  it "returns a URL" do
    get '/7442171028'
    last_response.body.should == "http://example.org/photo/7442171028.jpg"
    last_response.content_type.split(";").first.should == "text/plain"
  end
end