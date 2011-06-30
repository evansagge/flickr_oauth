require 'cgi'

module Flickr
  class Node
    attr_reader :name, :client
    
    def initialize(client, name)
      @client, @name = client, name
    end
    
    def require_parameters?
      true
    end
    
    def invoke(params = {})
      params = params.dup
      connection_options = extract_connection_options(params)
      response = client.connection(connection_options).get(build_rest_query(params))
      response.body
    end    
    
    def to_s
      name
    end
    
    protected
    
    def build_rest_query(params = {})
      format = params[:format] || client.format      
      params = { 
        :method => name, 
        :format => format, 
        :nojsoncallback => (format.to_s == 'json' ? 1 : nil)
      }.merge(params)
      query = params.map{|k,v| "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}" unless v.nil?}.compact.join("&")
      [Flickr::Client::REST_PATH, query].join("?")
    end    
    
    def extract_connection_options(params = {})
      Flickr::Client::CONFIGURATION_KEYS.inject({}) do |options, k| 
        if k == :format
          options[k.to_sym] = params.fetch(k)
        else
          options[k.to_sym] = params.delete(k)
        end if params.has_key?(k)
        options
      end
    end
      
    
    def method_missing(method_name, *args)
      node = Flickr::Node.new(client, [name, method_name].join('.'))
      node.require_parameters? and args.first.is_a?(Hash) ? node.invoke(args.first) : node
    end
  end
end