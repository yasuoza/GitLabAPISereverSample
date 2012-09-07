# Configure sinatra server
# For available variables, see
# http://www.sinatrarb.com/configuration.html

set :port, 4567
set :mention_to, 'YourTwitterID'
set :allowed_ip, '127.0.0.2'

# Twitter configuration
Twitter.configure do |config|
  config.consumer_key = 'consumer_key'
  config.consumer_secret = 'consumer_secret'
  config.oauth_token = 'your_oauth_token'
  config.oauth_token_secret = 'oauth_token_secret'
end
