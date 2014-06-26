require 'bundler'
Bundler.require
set :server, 'thin' 

enable :sessions

before do
  @webmaster = Yandex::Webmaster.new(app_id: APP_ID, app_password: APP_PASSWORD)
  @token = @webmaster.configuration.oauth_token
end


get '/' do
  redirect '/oauth/connect' if session[:access_token].blank?
  @webmaster.hosts.all.map(&:name).join('<br/>')
end

get '/oauth/access_token' do
  session[:access_token]
end

get '/oauth/connect' do
  redirect @webmaster.authorize_url
end

get '/oauth/callback' do
  @webmaster.authenticate(params[:code])
  session[:access_token] = @webmaster.configuration.oauth_token
  redirect '/'
end

