require_relative '../../spec_helper'
 
describe White::Charge do
 
  it "must create a new charge" do
    White.api_key = "sk_test_1234567890abcdefghijklmnopq"

    response = White::Charge.create(
      :amount => 400,
      :currency => "usd",
      :card => {
        :number => "4242424242424242",
        :exp_month => 11,
        :exp_year => 2014,
        :cvc => 123
      },
      :description => "Charge for test@example.com"
    )

    response['is_captured'].must_equal true
  end

   it "must list created charges" do
    response = White::Charge.all()
    response.wont_be_empty
   end
 
end