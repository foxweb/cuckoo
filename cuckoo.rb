require 'bundler'
Bundler.require

config_file 'config/config.yml'

enable :sessions

before do
  @webmaster = Yandex::Webmaster.new(settings.yandex_api)
  @token = @webmaster.configuration.oauth_token
end

get '/' do
  redirect '/oauth/connect' if session[:access_token].blank?
  'Access token: ' + session[:access_token]
end

post '/hosts/:host_id/original-texts' do
  'Host ID: ' + params[:host_id]
  # some magic
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

