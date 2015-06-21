#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra'
require 'slim'
require 'rest-client'
require 'json'
require_relative 'inc/levels'
require_relative 'inc/builddata'
require_relative 'inc/pagevars'
require_relative 'inc/Dataconn'

set :port, ENV['PORT'] || 8080
set :bind, ENV['IP'] || '0.0.0.0'

GIT_CLIENT_ID = ENV['GitHub_Client_ID']
GIT_CLIENT_SECRET = ENV['GitHub_Client_Secret']

RENV = ENV['RACK_ENV']

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
  def devenv?
    if RENV == 'test'
      return true
    else
      return false
    end
  end
  def auth_username
    return session[:username]
  end
end

get '/' do
  if session[:username].nil?
    @TRAVISBUILDNUMBER = Pagevars.setVars("CIbuild")
    #@TRAVISBUILDNUMBER = 'dev (latest)'
    @PageTitle = 'Home'
    slim :accountSignup
  else
    @TRAVISBUILDNUMBER = Pagevars.setVars("CIbuild")
    #@TRAVISBUILDNUMBER = 'dev (latest)'
    @PageTitle = 'Home'
    @UserName = session[:username]
    @UserImg = session[:userimg]
    slim :home
  end
end
get '/contact' do
  slim :contact
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
  session_code = params[:code]
  result = RestClient.post('https://github.com/login/oauth/access_token',
                          {:client_id => GIT_CLIENT_ID,
                           :client_secret => GIT_CLIENT_SECRET,
                           :code => session_code},
                           :accept => :json)
  session[:access_token] = JSON.parse(result)['access_token']
  auth_result = JSON.parse(RestClient.get('https://api.github.com/user',
                                        {:params => {:access_token => session[:access_token]}}))
  session[:username] = auth_result['login']
  session[:userimg] = auth_result['avatar_url']
  redirect "/"
end
get '/account/login' do
  @TRAVISBUILDNUMBER = Pagevars.setVars("CIbuild")
    #@TRAVISBUILDNUMBER = 'dev (latest)'
  @PageTitle = 'Log in'
  @ClientId = GIT_CLIENT_ID
  slim :accountLoginInfo
end
get '/account/logout' do
  @TRAVISBUILDNUMBER = Pagevars.setVars("CIbuild")
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
  # ProjExists() check
  @PageTitle = params[:userid] + '/' + params[:projid]
  @TRAVISBUILDNUMBER = Pagevars.setVars("CIbuild")
  if login?
    @UserName = session[:username]
    @UserImg = session[:userimg]
  elsif devenv?
    @UserName = 'TravisCIUser'
    @UserImg = 'https://avatars3.githubusercontent.com/u/4678601?v=3&s=460'
  else
    redirect "/"
  end
  @projName = params[:projid]
  @projDescription = 'A sample project that literally does nothing. Yep, nothing to see here.'
  @projOwner = params[:userid]
  @projContribNum = '1'
  @projCreateDate = 'June 1, 2015'
  @projCommitNum = 200
  @projLanguage = 'C++'
  slim :projProfile
end
get '/:userid' do
  @PageTitle = params[:userid]
  @TRAVISBUILDNUMBER = Pagevars.setVars("CIbuild")
  if login?
    @UserName = session[:username]
    @UserImg = session[:userimg]
  elsif devenv?
    @UserName = 'TravisCIUser'
    @UserImg = 'https://avatars3.githubusercontent.com/u/4678601?v=3&s=460'
  else
    redirect "/"
  end
  #Begin loading vars
  ustring = Dataconn.getUser(params[:userid])
  @userUserName = ustring.split(",")[0]
  @userPoints = ustring.split(",")[1]
  @userLevel = Levels.getLevelFromPoints(@userPoints)
  @levelName = Levels.getLevelName(@userLevel)
  @userImagePath = ustring.split(",")[2]
  @userFullName = ustring.split(",")[3]
  @userGeoLocation = ustring.split(",")[4]
  @userEmail = ustring.split(",")[5]
  slim :userProfile
end
