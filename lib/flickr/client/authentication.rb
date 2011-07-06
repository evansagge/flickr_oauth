module Flickr
  class Client
    module Authentication
      AUTHENTICATION_KEYS = [:consumer_key, :consumer_secret, :token, :token_secret]
      
      def authentication_options(options = {})
        {
          :consumer_key => consumer_key,
          :consumer_secret => consumer_secret,
          :token => token,
          :token_secret => token_secret
        }.merge(options.select{|k,v| AUTHENTICATION_KEYS.include?(k.to_sym)})
      end
      
    end
  end
end