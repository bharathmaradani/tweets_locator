# Tweet Locator

Tweet locator is a web application built using Ruby on Rails. It reads the configured tweets from the Twitter using the Twitter Streaming API.

### Technical Details
- rvm - 1.28.0 or higher (To manage Ruby version)
- Ruby - 2.2.2
- Rails - 3.2.22
- Backend data store - MongoDB

### Installation
From the project path run the following commands
```sh
gem install bundler
bundle install
rake db:mongoid:create_indexes # runs indexes defined in models
rake db:mongoid:create_indexes # Background job to populate tweets with location information
rails s
```
Once the above commands succeed, you can run the application on the browser http://localhost:3000/tweets