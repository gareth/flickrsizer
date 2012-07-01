require_relative 'spec_helper'

require 'flickrsizer'

describe Flickrsizer do
  use_vcr_cassette

  describe "::source_url" do
    context "given a Flickr photo ID" do
      it "returns the best matching URL" do
        Flickrsizer.source_url(7442171028).should == "http://farm8.staticflickr.com/7107/7442171028_79e58a5a45.jpg"
      end
    end
  end
end