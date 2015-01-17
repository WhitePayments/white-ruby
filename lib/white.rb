require "httparty"
require "white/charge"
require "white/errors/white_error"
require "white/errors/authentication_error"
require "white/errors/banking_error"
require "white/errors/request_error"
require "white/errors/processing_error"

module White
  
  include HTTParty

  @api_base = 'https://api.whitepayments.com/'

  def self.api_url(url='')
    @api_base + url
  end

  def self.handle_response(response)
    body = JSON.parse(response.body);

    if response.code.between?(200, 299) and !body.key?('error')
      # The request was successful
      return body
    end

    # There was an error .. check the response
    case body['error']['type']
    when 'banking'
      raise White::BankingError.new(body['error']['message'], body['error']['code'], response.code)

    when 'authentication'
      raise White::AuthenticationError.new(body['error']['message'], body['error']['code'], response.code)

    when 'processing'
      raise White::ProcessingError.new(body['error']['message'], body['error']['code'], response.code)

    when 'request'
      raise White::RequestError.new(body['error']['message'], body['error']['code'], response.code)
    end

    # Otherwise, raise a General error
    raise White::WhiteError.new(body['error']['message'], body['error']['code'], response.code)
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