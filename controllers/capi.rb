require_relative '../inc/api'

module CAPI
  get '/api' do
    "#{API.a()}"
  end
end
