require 'rspec'

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir     = 'spec/cassettes'
  c.hook_into                  :fakeweb
  c.default_cassette_options = { :record => :new_episodes }
end

RSpec::configure do |c|
  c.extend VCR::RSpec::Macros
end