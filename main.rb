#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra'
require 'slim'

set :port, ENV['PORT'] || 8080
set :bind, ENV['IP'] || '0.0.0.0'

helpers do
  def partial(template, locals = {})
    slim template, :layout => false, :locals => locals
  end
end

get '/' do
  @TRAVISBUILDNUMBER = 'ERROR'
  @PageTitle = 'Home'
  slim :home
end
#not_found do
#  slim :404
#end
