require_relative '../../../spec_helper'

describe White::AuthenticationError do
  
  it "must be thown with an invalid key" do
    White.api_key = "invalid"

    lambda {
      response = White::Charge.create(
        :amount => 400,
        :currency => "usd",
        :card => {
          :number => "3566002020360505",
          :exp_month => 11,
          :exp_year => 2014,
          :cvc => 123
        },
        :description => "Charge for test@example.com"
      )
    }.must_raise White::AuthenticationError
  end
end