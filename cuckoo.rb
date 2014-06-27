require 'bundler'
Bundler.require

config_file 'config/config.yml'

enable :sessions

before do
  @webmaster = Yandex::Webmaster.new(settings.yandex_api.symbolize_keys)
  @token = @webmaster.configuration.oauth_token
end

get '/' do
  redirect '/oauth/connect' if session[:access_token].blank?
  'Access token: ' + session[:access_token]
end

post '/hosts/:host_id/original-texts' do
  body =  'Host ID: ' + params[:host_id] + '<br/>'
  body += 'Original text: ' + params[:original_text] + '<br/>'
  body += 'Response: ' + post_to_yandex(params[:host_id], params[:original_text])
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

def post_to_yandex(host_id, body)
  url = "https://webmaster.yandex.ru/api/v2/hosts/#{host_id}/original-texts/"
  
  conn = Faraday.new(url: url)
  
  response = conn.post do |request|
    request.headers['Authorization'] = 'OAuth ' + (session[:access_token] || settings.demo_token)
    request.body = text_to_xml(body)
  end
  
  response.body
end

def text_to_xml(text)
<<-TEXT
<original-text>
  <content>#{text}</content>
</original-text>
TEXT
end
