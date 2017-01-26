require 'em-twitter'
require 'rest-client'

namespace :twitter do
  desc "Records tweets from twitter"
  task :record_tweets => :environment do
  	

		options = {
  		:path   => '/1.1/statuses/filter.json',
  		:params => { :track => 'Donald Trump' },
  		:oauth  => {
    		:consumer_key     => 'pZQeMqvIAPbhF6F8GaMd6kaQT',
    		:consumer_secret  => 'bxvovAYjcnmC70EAWNCRwVrTX42sIuzFrz5gU2k0iFmEcWgrQc',
    		:token            => '100489616-Ug5Bk1TRl4MJIabuJXmTURwoQ07NxqvmGBodAj0V',
    		:token_secret     => 'RuFCjyjyAMyl6M4UTpisIe3lgqiwQO3fRGOjk4TigKwmt'
  		}
		}

		EM.run do
		  client = EM::Twitter::Client.connect(options)

		  puts "Connected to Twitter using Event Machine....."
		  client.each do |tweet|
		  	latitude = nil
				longitude = nil
				hash_tags = []
				tweet_text = nil
		  	begin
			    parsed_tweet = JSON.parse(tweet)
			    location = parsed_tweet['user']['location']
			    hash_tags = parsed_tweet['entities']['hashtags']
			    tweet_text = parsed_tweet['text']

			    if !location.blank?
			    	begin
			    		# Get location coordinates from Google Maps
				    	gmap_location = RestClient.get("http://maps.google.com/maps/api/geocode/json?address=#{location}", headers={})
				    	parsed_location = JSON.parse(gmap_location)
				    	latitude = parsed_location['results'][0]['geometry']['location']['lat']
				    	longitude = parsed_location['results'][0]['geometry']['location']['lng']
			    	rescue => exception
			    		# this goes into logger
			    		puts "Location information failed to be recorded"
	  					puts exception.backtrace
			    	end
			    end

			    Tweet.create(
			    		tweet: tweet_text,
			    		location: {:lat => latitude.to_f, :lng => longitude.to_f},
			    		hashtags: hash_tags
			    	)
			  rescue => exception
	    		# this goes into logger
	    		puts "Failed to Record Tweet"
					puts exception.backtrace
			  end
		    
		  end
		end

	end

end
