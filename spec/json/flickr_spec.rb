require 'spec_helper'

describe 'JSON format' do
  let(:format) { :json }
  it_should_behave_like 'Flickr with specified format'
end