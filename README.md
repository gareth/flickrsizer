Prerequisites
=============

Flickrsizer uses ImageMagick, which should be installed on your platform before installing the RMagick gem. Be aware that (at least on Mac OS X with Ruby 1.9.1+[1]) openmp needs to be disabled, for example using:

    $ brew install -f imagemagick --disable-openmp

[1] http://stackoverflow.com/questions/2838307/why-is-this-rmagick-call-generating-a-segmentation-fault

Installation and setup
======================

Flickrsizer works best with RVM.

Flickrsizer uses Bundler to manage its dependencies.

    $ gem install bundler
    $ bundle install

Flickrsizer uses Foreman to manage its environment. Environment variables defined in a +.env+ file will automatically be loaded into the application by Foreman. The +.env.sample+ file defines the environment variables used by this application, use this to build your own +.env+ file

Usage
=====

Flickrsizer can be started using foreman with the included +Procfile+

    $ foreman start

Access the API by visiting a URL corresponsing to a Flickr photo ID:

    http://localhost:5000/7442171028

You can also add a +text+ HTTP query string parameter to have text overlayed on the image:

    http://localhost:5000/7442171028?text=MOOOOOOOOO!

The API returns a content body containing a URL where the processed photo can be found.