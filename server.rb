require 'sinatra'
require 'twitter'
require 'json'

# Configuration file
require File.expand_path('../config/setting', __FILE__)

post '/gitlab/twtr' do
  # Filter via ip address
  # If you want to filter with remote IP
  # Set allowed ip in config/settings.rb
  return nil unless request.ip == settings.allowed_ip

  data = JSON.parse(request.body.read)
  update_count = 0
  data['commits'].each do |commit|
    tweet("@#{settings.mention_to} #{data['repository']['name']} - #{commit['message']}")
    update_count += 1
  end
  JSON.generate(message: "Update status #{update_count} " + (update_count > 1 ? "times" : "time"))
end

not_found do
  'This is nowhere to be found'
end

private
def tweet(text)
  return unless production?
  Twitter.update(text)
end
