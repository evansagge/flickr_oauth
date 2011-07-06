require 'mime/types'

module Flickr
  class Client
    module Upload
      
      def upload(filepath, params = {})
        params.delete(:format) # Uploads can only allow for XML responses
        post(UPLOAD_PATH, { 
          :photo => Faraday::UploadIO.new(filepath, params.delete(:content_type) || get_content_type(filepath)) 
        }.merge(params))
      end
      
      protected
      
      def get_content_type(filename)
        ::MIME::Types.type_for(filename).first
      end
      
    end
  end
end