shared_examples_for 'Flickr with specified format' do
  describe Flickr do
    context 'flickr.test.echo' do
      describe 'no oauth token' do
        use_vcr_cassette
        
        let(:flickr) { Flickr.new(:format => format) }
        it 'raises a Flickr::Error exception' do
          expect { flickr.test.echo :foo => 'bar' }.to raise_exception(Flickr::Error, /Invalid API key/i)
        end
      end
    
      describe 'with oauth token' do
        use_vcr_cassette
        
        let(:flickr) { Flickr.new({:format => format}.merge(oauth_options)) }
        it 'does not raise a Flickr::Error exception' do
          expect { flickr.test.echo :foo => 'bar' }.to_not raise_error(Flickr::Error)
        end
        
        it 'responds with the original request parameters' do
          response = flickr.test.echo({:foo => 'bar', :format => format}.merge(oauth_options))
          if format == :json
            response['method']['_content'].should == 'flickr.test.echo'
            response['foo']['_content'].should == 'bar'
          else
            response['rsp']['method'].should == 'flickr.test.echo' 
            response['rsp']['foo'].should == 'bar'
          end  
        end        
      end
    end
  end
  
  describe :flickr do
    context 'flickr.test.echo' do
      describe 'no oauth token' do
        use_vcr_cassette
        
        it 'raises a Flickr::Error exception' do
          expect { flickr.test.echo :foo => 'bar', :format => format }.to raise_exception(Flickr::Error, /Invalid API key/i)
        end
      end
    
      describe 'with oauth token' do
        use_vcr_cassette
        
        it 'does not raise a Flickr::Error exception' do
          expect { flickr.test.echo oauth_options.reverse_merge(:foo => 'bar', :format => format, :enable_logging => true) }.to_not raise_error(Flickr::Error)
        end
        
        it 'responds with the original request parameters' do
          response = flickr.test.echo({:foo => 'bar', :format => format}.merge(oauth_options))
          if format == :json
            response['method']['_content'].should == 'flickr.test.echo'
            response['foo']['_content'].should == 'bar'
          else
            response['rsp']['method'].should == 'flickr.test.echo' 
            response['rsp']['foo'].should == 'bar'
          end  
        end
      end
    end    
  end
end