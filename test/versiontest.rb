require_relative "../test_helper"
require "test/unit"
require 'rack/test'
require_relative '../main'
require_relative '../inc/levels'

class TestVersion < Test::Unit::TestCase
  def test_unit_levels
    i = 0
    r = ""
    while r != "Ultimate Coder" do
      Levels.getLevelName(i)
      i++
    end
    assert r != ""
  end
  def test_unit_levelsnum
    i = 100
    r = 100
    while r != 0 do
      r = Levels.getLevelFromPoints(i)
      i = i + 100
    end
    assert r == 0
  end
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
  def test_api_notifications
    get '/get/notifications'
    assert last_response.ok?
  end
end
