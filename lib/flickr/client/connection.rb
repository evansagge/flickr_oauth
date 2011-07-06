require 'faraday'
require 'faraday_middleware'
require 'faraday/response/raise_flickr_error'

module Flickr
  class Client
    module Connection
    
      def connection(options = {})
        @connection = Faraday.new(:url => endpoint(options[:secure])) do |builder|
          builder.use Faraday::Request::OAuth, authentication_options(options)
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
    
      def adapter
        @adapter || Faraday.default_adapter
      end    
    
      protected
    
      def extract_connection_options(params = {})
        CONFIGURATION_KEYS.inject({}) do |options, k| 
          if params.has_key?(k)
            options[k.to_sym] = (k == :format ? params.fetch(k) : params.delete(k))
          end
          options
        end
      end
    end
  end
end