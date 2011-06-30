require 'faraday/error'

module Flickr
  class Error < StandardError
    attr_reader :code
    
    def initialize(code, message)
      @code = code
      @message = message
      super [@code, @message].join(' - ')
    end
  end
end
      