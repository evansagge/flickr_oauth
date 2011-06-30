require 'faraday'
require 'faraday_middleware'
require 'faraday/response/raise_flickr_error'
require 'flickr/node'

module Flickr
  class Client
    DEFAULT_ENDPOINT = 'http://api.flickr.com'.freeze
    SECURE_ENDPOINT = 'https://secure.flickr.com'.freeze
    REST_PATH = '/services/rest'.freeze
    UPLOAD_PATH = '/services/upload'.freeze
    REPLACE_PATH = '/services/resplace'.freeze
    
    CONFIGURATION_KEYS = [
      :consumer_key,
      :consumer_secret,
      :token,
      :token_secret,
      :secure,
      :format,
      :enable_logging
    ]
  
    attr_accessor *CONFIGURATION_KEYS
  
    def initialize(options = {})
      CONFIGURATION_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end
    
    def endpoint(secure = false)
      secure or self.secure  ? SECURE_ENDPOINT : DEFAULT_ENDPOINT
    end
    
    def authentication(options = {})
      {
        :consumer_key => consumer_key,
        :consumer_secret => consumer_secret,
        :token => token,
        :token_secret => token_secret
      }.merge(options.select{|k,v| [:consumer_key, :consumer_secret, :token, :token_secret].include?(k.to_sym)})
    end
    
    def adapter
      @adapter || Faraday.default_adapter
    end
        
    def connection(options = {})
      @connection = Faraday.new(:url => endpoint(options[:secure])) do |builder|
        builder.use Faraday::Request::OAuth, authentication(options)
        builder.use Faraday::Request::Multipart
        builder.use Faraday::Request::UrlEncoded
                
        builder.use Faraday::Response::RaiseFlickrError
        if (options[:format] or format).to_s == 'json'
          builder.use Faraday::Response::ParseJson
        else
          builder.use Faraday::Response::ParseXml
        end        
        builder.use Faraday::Response::RaiseError
        builder.use Faraday::Response::Logger if options[:enable_logging] or enable_logging
        
        builder.adapter adapter
      end
    end
  
    protected
  
    def method_missing(method_name, *args)
      args.empty? ? Flickr::Node.new(self, ['flickr', method_name].join('.')) : super
    end    
    
  end
end
