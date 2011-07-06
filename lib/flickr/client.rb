require 'flickr/client/authentication'
require 'flickr/client/connection'
require 'flickr/client/request'
require 'flickr/node'

module Flickr  
  class Client
    include Flickr::Client::Authentication
    include Flickr::Client::Connection
    include Flickr::Client::Request
    
    CONFIGURATION_KEYS = [
      :consumer_key,
      :consumer_secret,
      :token,
      :token_secret,
      :secure,
      :format,
      :enable_logging,
      :normalize
    ]    
  
    attr_accessor *CONFIGURATION_KEYS
  
    def initialize(options = {})
      CONFIGURATION_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end
    
    def endpoint(secure = false)
      secure or self.secure  ? Flickr::SECURE_ENDPOINT : Flickr::DEFAULT_ENDPOINT
    end
  
    protected  
  
    def method_missing(method_name, *args)
      # super unless ['reflection'].include?(method_name.to_s)      
      args.empty? ? Flickr::Node.new(self, ['flickr', method_name].join('.')) : super
    end
    
  end
end
