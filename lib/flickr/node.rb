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
      client.request(:get, Flickr::REST_PATH, params.merge(:method => name))
    end
    
    def to_s
      name
    end
    
    protected
    
    def method_missing(method_name, *args)
      node = Flickr::Node.new(client, [name, method_name].join('.'))
      node.require_parameters? and args.first.is_a?(Hash) ? node.invoke(args.first) : node
    end
  end
end