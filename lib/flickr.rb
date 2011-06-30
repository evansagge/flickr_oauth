require 'flickr/client'

module Flickr
  extend self
  
  def new(options = {})
    Flickr::Client.new(options)
  end
end

def flickr
  $flickr ||= Flickr.new
end