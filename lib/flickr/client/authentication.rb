module Flickr
  class Client
    module Authentication
      
      def authentication_options(options = {})
        {
          :consumer_key => options[:consumer_key] || consumer_key,
          :consumer_secret => options[:consumer_secret] || consumer_secret,
          :token => options[:token] || token,
          :token_secret => options[:token_secret] || token_secret
        }
      end
      
    end
  end
end