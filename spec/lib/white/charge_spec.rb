require_relative '../../spec_helper'
 
describe White::Charge do
 
  it "must create a new charge" do
    White.api_key = "test_sec_k_25dd497d7e657bb761ad6"

    response = White::Charge.create(
      :amount => 400,
      :currency => "usd",
      :card => {
        :number => "4242424242424242",
        :exp_month => 11,
        :exp_year => 2016,
        :cvc => 123
      },
      :description => "Charge for test@example.com"
    )

    response['captured_amount'].must_equal 400
  end

   it "must list created charges" do
    response = White::Charge.all()
    response.wont_be_empty
   end
 
end
