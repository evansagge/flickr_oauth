module Flickr
  class Client
    module Request
    
      def request(method, path, params = {})
        params = params.dup
        options = extract_connection_options(params)
        response = connection(options).send(method, build_rest_query(path, params))
        if options[:normalize]
          options[:format].to_s == 'json' ? normalize_json(response.body) : normalize_xml(response.body)
        else
          response.body
        end
      end
    
      # protected
    
      def build_rest_query(path, params = {})
        params[:format] ||= client.format
        params[:nojsoncallback] = (params[:format].to_s == 'json' ? 1 : nil)
        query = params.map{|k,v| "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}" unless v.nil?}.compact.join("&")
        [path, query].join("?")
      end
      
      def normalize_json(raw)
        if raw.is_a?(Hash)
          if raw.keys.size == 1 and raw.has_key?('_content')
            raw['_content']
          else
            raw.each_pair do |k, v|
              raw[k] = normalize_json(v)
            end
          end
        elsif raw.is_a?(Array)
          raw.collect{|r| normalize_json(r) }
        else
          raw
        end
      end
      
      def normalize_xml(xml_result)
        xml_result['rsp']
      end
    
    end
  end
end    