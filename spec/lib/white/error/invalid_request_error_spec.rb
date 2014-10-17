require_relative '../../../spec_helper'

describe White::InvalidRequestError do
  
  it "must be thown with invalid_request_error" do
    White.api_key = "sk_test_1234567890abcdefghijklmnopq"

    lambda {
      response = White::Charge.create(
        :amount => 400,
        :currency => "usd",
        :card => {
          :number => "1",
          :exp_month => 11,
          :exp_year => 2014,
          :cvv => 123
        },
        :description => "Charge for test@example.com"
      )
    }.must_raise White::InvalidRequestError
  end
end