#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra'
require 'slim'

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

def getLevelName(lnum)
  if lnum == 0
    return 'Unknown'
  elsif lnum == 1
    return 'Hello World!'
  elsif lnum == 2
    return 'Modder'
  elsif lnum == 3
    return 'Coffee Intern'
  elsif lnum == 4
    return 'Tutorial Reader'
  elsif lnum == 5
    return 'Google-fu Master'
  elsif lnum == 6
    return 'CS101 Sensei'
  elsif lnum == 7
    return 'Commit Factory'
  else
    return 'Ultimate Coder'
  end
end
def getLevelFromPoints(points)
  if points >= 0 and points < 100
    return 1
  elsif points >= 100 and points < 200
    return 2
  elsif points >= 200 and points < 400
    return 3
  elsif points >= 400 and points < 800
    return 4
  elsif points >= 800 and points < 1600
    return 5
  elsif points >= 1600 and points < 3200
    return 6
  elsif points >= 3200 and points < 6400
    return 7
  elsif points >= 6400
    return 8
  else
    return 0
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
get '/:userid' do
  # UserExists() check
  @PageTitle = params[:userid]
  @userUserName = params[:userid]
  @userPoints = 8000
  @userLevel = getLevelFromPoints(@userPoints)
  @levelName = getLevelName(@userLevel)
  @userImagePath = 'https://avatars3.githubusercontent.com/u/4678601?v=3&s=460'
  @userFullName = 'Joshua Zenn'
  @userGeoLocation = 'United States'
  @userEmail = 'user@sample.com'
  slim :userProfile
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
