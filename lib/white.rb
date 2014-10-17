require "httparty"
require "white/charge"
require "white/errors/white_error"
require "white/errors/authentication_error"
require "white/errors/card_error"
require "white/errors/invalid_request_error"

module White
  
  include HTTParty

  @api_base = 'https://api.whitepayments.com'

  def self.api_url(url='')
    @api_base + url
  end

  def self.handle_response(response)
    body = JSON.parse(response.body);
    if(response.code == 400 and body['error']['type'] == 'card_error')
      raise White::CardError.new(body['error']['message'], body['error']['code'], 400)
    end
    if(response.code == 422)
      raise White::InvalidRequestError.new(body['error']['message'], 422)
    end

    if(response.code == 401)
      raise White::AuthenticationError.new(body['error']['message'], 422)
    end

    if(response.code >= 500 && response.code < 600)
      raise White::WhiteError.new(body['error']['message'], response.code)
    end

    body
  end

  def self.post(url, body={})
    options = {basic_auth: {username: api_key, password: ''}}
    options.merge!({body: body})
    response = HTTParty.post(url, options)
    self.handle_response(response)

  end

  def self.get(url, query={})
    options = {basic_auth: {username: api_key, password: ''}}
    options.merge!({query: query})
    response = HTTParty.get(url, options)
    JSON.parse(response.body);
  end

  class << self
    attr_accessor :api_key
  end
end