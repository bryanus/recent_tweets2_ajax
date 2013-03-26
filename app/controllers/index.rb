require 'twitter'

get '/' do
  erb :index
end

get '/:username' do
  @user = User.find_or_create_by_username(params[:username])
  erb :tweets
end

get '/:username/tweets' do
  p '*' * 20
  p 'You made it!'
  p '*' * 20
  @user = User.find_or_create_by_username(params[:username])

  puts "user.tweets.empty? #{@user.tweets.empty?}"
  puts "user.tweets.stale? #{@user.tweets_stale?}"

  if @user.tweets.empty? || @user.tweets_stale?
    @user.fetch_tweets!
  end

  @tweets = @user.tweets.limit(10)
  erb :_tweet_list, :layout => false
end
