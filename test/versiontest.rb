require_relative "../test_helper"
require "test/unit"
require 'rack/test'
require_relative '../main'

class TestVersion < Test::Unit::TestCase
  include Rack::Test::Methods
  def app
    Sinatra::Application
  end
  def test_homepage
    get '/'
    assert last_response.ok?
  end
  def test_homecontactpage
    get '/contact'
    assert last_response.ok?
  end
  def test_loginpage
    get '/account/login'
    assert last_response.ok?
  end
  def test_logoutpage
    get '/account/logout'
    assert last_response.ok?
  end
  def test_projectpage
    get '/ARMmaster17/code.me'
    assert last_response.ok?
  end
  def test_userpage
    get '/ARMmaster17'
    assert last_response.ok?
  end
  def test_api_api
    get '/api'
    assert last_response.ok?
  end
end
