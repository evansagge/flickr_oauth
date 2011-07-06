require 'spec_helper'

describe 'flickr.upload' do
  let(:image_path) { File.expand_path('../../fixtures/test.jpg', __FILE__) }
  let(:image_info) { { :title => 'test upload', :description => 'this is an image for testing flickr uploads', :tags => 'test upload' } }
  
  use_vcr_cassette
  
  context ':normalize => true' do
    let(:result) { flickr.upload(image_path, {:normalize => true}.merge(image_info).merge(oauth_options)) }
    
    it 'returns the uploaded image\'s Flickr photo ID' do
      result['photoid'].should =~ %r(\d)
    end
    
    describe 'photo' do
      let(:photo) { flickr.photos.getInfo({ :photo_id => result['photoid'], :normalize => true }.merge(oauth_options)) }
      
      it 'has a title' do
        photo['photo']['title'].should == image_info[:title]
      end
      
      it 'has a description' do
        photo['photo']['description'].should == image_info[:description]
      end
      
      it 'has tags' do
        photo['photo']['tags']['tag'].join(" ").should == image_info[:tags]
      end
    end
  end

end