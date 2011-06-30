require 'flickr/error'

module Faraday
  class Response::RaiseFlickrError < Response::Middleware
    
    def on_complete(env)
      if env[:body]['rsp'] and env[:body]['rsp']['stat'] == 'fail'
        raise Flickr::Error.new(env[:body]['rsp']['err']['code'] , env[:body]['rsp']['err']['msg'])
      elsif env[:body]['stat'] == 'fail'
        raise Flickr::Error.new(env[:body]['code'] , env[:body]['message'])
      end
    end
  end
end