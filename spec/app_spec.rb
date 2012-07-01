require_relative '../app'

require 'rspec'
require 'rack/test'

set :environment, :test

describe 'Flickrsizer App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "requires an id parameter" do
    get '/'

    last_response.should be_a_client_error
    last_response.body.should == "Missing 'id' parameter"
  end
end