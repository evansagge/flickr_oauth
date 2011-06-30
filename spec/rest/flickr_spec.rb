require 'spec_helper'

describe 'REST format' do
  let(:format) { :rest }
  it_should_behave_like 'Flickr with specified format'
end