# Written January 2015
# This bot is at: https://twitter.com/decision_bot_
# Doesn't actually run anymore because Twitter banned the account from posting because it was spammy. Oops.

require 'rubygems'
require 'twitter'


#Fill in with keys from Twitter
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ""
  config.consumer_secret     = ""
  config.access_token        = ""
  config.access_token_secret = ""
end

client.search(/#{Regexp.quote("(Should I)")}/, result_type: "recent").take(40).each do |tweet|
  # Check for tweets containing "should I", and not a retweet or reply tweet.
  if(((tweet.text.include? "Should I") || (tweet.text.include? "Should i")|| (tweet.text.include? "should I") || (tweet.text.include? "should i")) && tweet.text[0] != '@' && tweet.text[0] != 'R' && tweet.text[1] != 'R')
    answer = ["Yes", "No"].sample
    id = tweet.id
    tweetText = "@#{tweet.user.screen_name} #{answer}, #{tweet.user.name}."
    client.update(tweetText, in_reply_to_status_id: id)
  end
end

