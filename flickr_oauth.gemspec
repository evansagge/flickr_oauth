# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "flickr_oauth/version"

Gem::Specification.new do |s|
  s.name        = "flickr_oauth"
  s.version     = FlickrOAuth::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Evan Sagge"]
  s.email       = ["evansagge@gmail.com"]
  s.homepage    = "http://github.com/evansagge/flickr_oauth"
  s.summary     = %q{Flickr API adapter using OAuth}
  s.description = %q{}

  s.rubyforge_project = "flickr_oauth"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.autorequire   = 'flickr'
  
  s.add_dependency 'faraday', '>= 0.7'
  s.add_dependency 'faraday_middleware', '>= 0.7.0.rc1'
  s.add_dependency 'mime-types'
  s.add_dependency 'multipart-post'
  s.add_dependency 'multi_json'
  s.add_dependency 'multi_xml'
  s.add_dependency 'simple_oauth'
  s.add_dependency 'rake'
  s.add_dependency 'json'
  s.add_development_dependency 'rspec', '>= 2.6'
  s.add_development_dependency 'webmock', '>= 1.6'
  s.add_development_dependency 'vcr', '>= 1.7'
end
