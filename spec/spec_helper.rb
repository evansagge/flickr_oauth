require "rubygems"
require "bundler"
Bundler.setup

require 'rspec'
require 'vcr'
require 'flickr_oauth'

$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)

VCR.config do |config|
  config.cassette_library_dir = 'spec/fixtures/cassettes'
  config.stub_with :webmock
end

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros  
  config.include RSpec::Matchers
  config.mock_with :rspec
end

def oauth_options
 {
   :consumer_key => '', 
   :consumer_secret => '',
   :token => '', 
   :token_secret => ''
 }
end

# require 'oauth_keys'
# flickr.enable_logging = true # watch the magic come alive!