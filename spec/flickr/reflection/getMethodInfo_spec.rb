require 'spec_helper'

describe flickr.reflection.getMethodInfo do
  let(:method_name) { 'flickr.photos.search' }
  
  context ':format => :json' do
    use_vcr_cassette
    
    context ':normalize => false' do
      let(:result) { flickr.reflection.getMethodInfo({:method_name => method_name, :format => 'json'}.merge(oauth_options)) }
      
      it 'returns raw method information' do
        result['method']['name'].should be_a(String)
        result['method']['description']['_content'].should be_a(String)
      end
      
      it 'returns raw method arguments information' do
        result['arguments']['argument'].should be_an(Array)
        result['arguments']['argument'].each do |argument|
          argument['name'].should be_a(String)
          argument['_content'].should be_a(String)
        end
      end
      
      it 'returns raw method errors information' do
        result['errors']['error'].should be_an(Array)
        result['errors']['error'].each do |error|
          error['message'].should be_a(String)
          error['_content'].should be_a(String)
        end
      end      
    end
    
    context ':normalize => true' do
      let(:result) { flickr.reflection.getMethodInfo({:method_name => method_name, :format => 'json', :normalize => true}.merge(oauth_options)) }
      
      it 'returns normalized method information' do
        result['method']['name'].should be_a(String)
        result['method']['description'].should be_a(String)
      end
    end
  end
  
  context ':format => :rest' do
    use_vcr_cassette
    
    context ':normalize => false' do
      let(:result) { flickr.reflection.getMethodInfo({:method_name => method_name, :format => 'rest'}.merge(oauth_options)) }
      
      it 'returns raw method information' do
        result['rsp']['method']['name'].should be_a(String)
        result['rsp']['method']['description'].should be_a(String)
      end    
      
      it 'returns raw method arguments information' do
        result['rsp']['arguments']['argument'].should be_an(Array)
      end
      
      it 'returns raw method errors information' do
        result['rsp']['errors']['error'].should be_an(Array)
      end      
    end
    
    context ':normalize => true' do
      let(:result) { flickr.reflection.getMethodInfo({:method_name => method_name, :format => 'rest', :normalize => true}.merge(oauth_options)) }
      
      it 'returns normalized method information' do
        result['method']['name'].should be_a(String)
        result['method']['description'].should be_a(String)
      end      
    end    
  end  
end