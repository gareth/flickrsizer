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

  describe "::file" do
    before do
      Flickrsizer.stub(:source_url).with(7442171028) { "http://farm8.staticflickr.com/7107/7442171028_79e58a5a45.jpg" }
      File.stub(:open).with("tmp/photo/7442171028.jpg") { mock("IO") }
    end

    context "given a cached Flickr photo ID" do
      before do
        File.stub(:exists?).with("tmp/photo/7442171028.jpg") { true }
      end

      it "doesn't download a new copy of the file" do
        Flickrsizer.should_not_receive(:open).with("http://farm8.staticflickr.com/7107/7442171028_79e58a5a45.jpg")
        Flickrsizer.file(7442171028)
      end
    end

    context "given a new Flickr photo ID" do
      before do
        File.stub(:exists?).with("tmp/photo/7442171028.jpg") { false }
      end

      it "downloads a new copy of the file" do
        Flickrsizer.should_receive(:open).with("http://farm8.staticflickr.com/7107/7442171028_79e58a5a45.jpg") { mock("IO", :read => "")}
        File.should_receive(:open).with("tmp/photo/7442171028.jpg", /w/)
        Flickrsizer.file(7442171028)
      end
    end
  end
end