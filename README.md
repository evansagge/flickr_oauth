flickr_oauth
=
Flickr API adapter using OAuth authentication method.

USAGE
-
You can instantiate an instance of `Flickr`

    require 'flickr_oauth'
    
    flickr = Flickr.new(
      :consumer_key => CONSUMER_KEY, 
      :consumer_secret => CONSUMER_SECRET, 
      :token => OAUTH_ACCESS_TOKEN, 
      :token_secret => OAUTH_ACCESS_TOKEN_SECRET,
      :format => :json
    )
    flickr.test.echo(:foo => 'bar')

Or, you can use the `flickr` method:

    require 'flickr_oauth'
    
    flickr.test.echo(:foo => 'bar', 
      :consumer_key => CONSUMER_KEY, 
      :consumer_secret => CONSUMER_SECRET, 
      :token => OAUTH_ACCESS_TOKEN, 
      :token_secret => OAUTH_ACCESS_TOKEN_SECRET,
      :format => :json
    )

TODO
-
* flickr_oauth may support all of the existing Flickr API methods, with the exception of those that require no additional arguments, to name a few:

  - `flickr.test.null`
  - `flickr.test.login`
  - `flickr.photos.licenses.getInfo`

* Upload/replace
* More tests

ACKNOWLEDGEMENT
-
Much of the code has been patterned around the [twitter](https://github.com/jnunemaker/twitter) gem.