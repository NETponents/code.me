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
