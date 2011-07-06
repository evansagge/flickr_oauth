require 'spec_helper'
require 'json'

describe flickr.reflection.getMethods do
  context ':format => :json' do
    use_vcr_cassette
    
    context ':normalize => false' do
      let(:result) { flickr.reflection.getMethods({:format => 'json'}.merge(oauth_options)) }
    
      it 'returns all Flickr API methods in raw Flickr JSON format' do
        result['methods']['method'].each do |method|
          Flickr::METHODS.should include(method['_content'])
        end
      end
    end
    
    context ':normalize => true' do
      let(:result) { flickr.reflection.getMethods({:format => 'json', :normalize => true}.merge(oauth_options)) }
      
      it 'returns all Flickr API methods in normalized JSON format' do
        result['methods']['method'].each do |method|
          Flickr::METHODS.should include(method)
        end
      end      
    end
  end
  
  context ':format => :rest' do
    use_vcr_cassette
    
    context ':normalize => false' do
      let(:result) { flickr.reflection.getMethods({:format => 'rest'}.merge(oauth_options)) }
    
      it 'returns all Flickr API methods in raw Flickr REST format' do
        result['rsp']['methods']['method'].each do |method|
          Flickr::METHODS.should include(method)
        end
      end
    end
    
    context ':normalize => true' do
      let(:result) { flickr.reflection.getMethods({:format => 'rest', :normalize => true}.merge(oauth_options)) }
      
      it 'returns all Flickr API methods in normalized REST format' do
        result['methods']['method'].each do |method|
          Flickr::METHODS.should include(method)
        end
      end      
    end    
  end
  
end