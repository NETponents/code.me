#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra'
require 'slim'
require 'rest-client'
require 'json'
require_relative 'inc/levels'
require_relative 'inc/builddata'

set :port, ENV['PORT'] || 8080
set :bind, ENV['IP'] || '0.0.0.0'

GIT_CLIENT_ID = ENV['GitHub_Client_ID']
GIT_CLIENT_SECRET = ENV['GitHub_Client_Secret']

enable :sessions

helpers do
  def partial(template, locals = {})
    slim template, :layout => false, :locals => locals
  end
  def login?
    if session[:username].nil?
      return false
    else
      return true
    end
  end
  def auth_username
    return session[:username]
  end
end

get '/' do
  if session[:username].nil?
    @TRAVISBUILDNUMBER = getCIstring()
    #@TRAVISBUILDNUMBER = 'dev (latest)'
    @PageTitle = 'Home'
    slim :accountSignup
  else
    @TRAVISBUILDNUMBER = getCIstring()
    #@TRAVISBUILDNUMBER = 'dev (latest)'
    @PageTitle = 'Home'
    @UserName = session[:username]
    @UserImg = session[:userimg]
    slim :home
  end
end
get '/contact' do
  if session[:username].nil?
    redirect "/"
  else
    slim :contact
  end
end
post '/contact' do
  if session[:username].nil?
    redirect "/"
  else
    RestClient.post('https://api.github.com/repos/NETponents/code.me/issues',
                  {:params => {:access_token => session[:access_token],
                    :title => params[:title],
                    :body => "@" + params[:uname] + "(" + params[:name] + "): " + params[:message]}})
    slim :contact2
  end
end
get '/login/oauthcallback' do
  #session_code = request.env['rack.request.query_hash']['code']
  puts 't-0'
  session_code = params[:code]
  puts 't-1'
  result = RestClient.post('https://github.com/login/oauth/access_token',
                          {:client_id => GIT_CLIENT_ID,
                           :client_secret => GIT_CLIENT_SECRET,
                           :code => session_code},
                           :accept => :json)
  puts 't-2'
  session[:access_token] = JSON.parse(result)['access_token']
  puts 't-3'
  auth_result = JSON.parse(RestClient.get('https://api.github.com/user',
                                        {:params => {:access_token => session[:access_token]}}))
  puts 't-4'
  session[:username] = auth_result['login']
  puts 't-5'
  session[:userimg] = auth_result['avatar_url']
  puts 't-6'
  redirect "/"
end
get '/account/login' do
  @TRAVISBUILDNUMBER = getCIstring()
    #@TRAVISBUILDNUMBER = 'dev (latest)'
  @PageTitle = 'Log in'
  @ClientId = GIT_CLIENT_ID
  slim :accountLoginInfo
end
get '/account/logout' do
  @TRAVISBUILDNUMBER = getCIstring()
  #@TRAVISBUILDNUMBER = 'dev (latest)'
  @PageTitle = 'Logged out'
  session[:username] = nil
  session[:userimg] = nil
  session[:access_token] = nil
  slim :accountLoggedOut
end

#not_found do
#  slim :404
#end

get '/:userid/:projid' do
  if session[:username].nil?
    redirect "/"
  else
    # ProjExists() check
    @PageTitle = params[:userid] + '/' + params[:projid]
    @TRAVISBUILDNUMBER = getCIstring()
    #@TRAVISBUILDNUMBER = 'dev (latest)'
    @UserName = session[:username]
    @UserImg = session[:userimg]
    @projName = params[:projid]
    @projDescription = 'A sample project that literally does nothing. Yep, nothing to see here.'
    @projOwner = params[:userid]
    @projContribNum = '1'
    @projCreateDate = 'June 1, 2015'
    @projCommitNum = 200
    @projLanguage = 'C++'
    slim :projProfile
  end
end
get '/:userid' do
  if session[:username].nil?
    redirect "/"
  else
    # UserExists() check
    @PageTitle = params[:userid]
    @TRAVISBUILDNUMBER = getCIstring()
    #@TRAVISBUILDNUMBER = 'dev (latest)'
    @UserName = session[:username]
    @UserImg = session[:userimg]
    @userUserName = params[:userid]
    @userPoints = 800
    @userLevel = getLevelFromPoints(@userPoints)
    @levelName = getLevelName(@userLevel)
    @userImagePath = 'https://avatars3.githubusercontent.com/u/4678601?v=3&s=460'
    @userFullName = 'Mr Placeholder'
    @userGeoLocation = 'United States'
    @userEmail = 'user@sample.com'
    slim :userProfile
  end
end
