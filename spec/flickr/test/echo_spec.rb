require 'spec_helper'

describe flickr.test.echo do
  context ':format => :json' do
    use_vcr_cassette
    
    context ':normalize => false' do
      let(:result) { flickr.test.echo({:foo => 'bar', :format => 'json'}.merge(oauth_options)) }
      
      it 'responds with the original request parameters' do
        result['method']['_content'].should == 'flickr.test.echo'
        result['foo']['_content'].should == 'bar'
        result['format']['_content'].should == 'json'
      end
    end
    
    context ':normalize => true' do
      let(:result) { flickr.test.echo({:foo => 'bar', :format => 'json', :normalize => true}.merge(oauth_options)) }
      
      it 'responds with the original request parameters' do
        result['method'].should == 'flickr.test.echo'
        result['foo'].should == 'bar'
        result['format'].should == 'json'        
      end      
    end
  end
  
  context ':format => :rest' do
    use_vcr_cassette
    
    context ':normalize => false' do
      let(:result) { flickr.test.echo({:foo => 'bar', :format => 'rest'}.merge(oauth_options)) }
      
      it 'responds with the original request parameters' do
        result['rsp']['method'].should == 'flickr.test.echo'
        result['rsp']['foo'].should == 'bar'
        result['rsp']['format'].should == 'rest'
      end      
    end
    
    context ':normalize => true' do
      let(:result) { flickr.test.echo({:foo => 'bar', :format => 'rest', :normalize => true}.merge(oauth_options)) }
      
      it 'responds with the original request parameters' do
        result['method'].should == 'flickr.test.echo'
        result['foo'].should == 'bar'
        result['format'].should == 'rest'        
      end
    end
  end  
end