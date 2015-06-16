#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra'
require 'slim'
require_relative 'inc/levels'

set :port, ENV['PORT'] || 8080
set :bind, ENV['IP'] || '0.0.0.0'

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
    @TRAVISBUILDNUMBER = 'ERROR'
    @PageTitle = 'Home'
    slim :accountSignup
  else
    @TRAVISBUILDNUMBER = 'ERROR'
    @PageTitle = 'Home'
    @UserName = session[:username]
    slim :home
  end
end
get '/account/login' do
  @TRAVISBUILDNUMBER = 'ERROR'
  @PageTitle = 'Log in'
  #slim :accountLogin
  session[:username] = 'Test User'
  redirect "/"
end
post '/account/login' do
  @TRAVISBUILDNUMBER = 'ERROR'
  @PageTitle = 'Log in'
  session[:username] = params[:uname]
  redirect "/"
end
get '/account/logout' do
  @TRAVISBUILDNUMBER = 'ERROR'
  @PageTitle = 'Logged out'
  session[:username] = nil
  slim :accountLoggedOut
end

#not_found do
#  slim :404
#end

get '/:userid/:projid'
  if session[:username].nil?
    slim :accountSignup
  else
    # ProjExists() check
    @PageTitle = params[:userid] + '/' + params[:projid]
    @TRAVISBUILDNUMBER = 'ERROR'
    @UserName = session[:username]
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
    slim :accountSignup
  else
    # UserExists() check
    @PageTitle = params[:userid]
    @TRAVISBUILDNUMBER = 'ERROR'
    @UserName = session[:username]
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
