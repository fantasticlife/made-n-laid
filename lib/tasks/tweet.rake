gem 'twitter'
require 'twitter'

consumer_key = 'YRwr5vS3eETYNiboI7XiwpvbF'
consumer_secret = 'cXaJhOX01ZRykVbwQgWtCyMcDVpBhxPfI0GdtBT8TAIvgBPovT'
access_token = '1275011030146584577-wQD5J7GR6kxmCXqQ9DprJAaijVzVY0'
access_secret = '2530QYmhDdOmswPwIG4wrNg3eNR4EK8hxZUbb7A9Y5ZWW'


task :tweet => [
  :tweet_the_untweeted] do
end

task :tweet_the_untweeted => :environment do
  puts "tweeting new instruments"
  instruments = Instrument.where( is_tweeted: false )
  puts "tweeting #{instruments.size} instruments"
  instruments.each do |instrument|
    puts instrument.tweet_text
    client = TwitterOAuth::Client.new(
        :consumer_key => consumer_key,
        :consumer_secret => consumer_secret,
        :token => access_token,
        :secret => access_secret
    )
    puts "Authorised: #{client.authorized?}"
  
    client.update( instrument.tweet_text )
    instrument.is_tweeted = true
    instrument.save
  end
end