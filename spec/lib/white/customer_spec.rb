require_relative '../../spec_helper'
 
describe White::Customer do
 
  it "must create a new customer" do
    White.api_key = "sk_test_1234567890abcdefghijklmnopq"

    response = White::Customer.create(
      :description => "John Doe",
      :email => "john@doe.com",
      :card => {
        :number => "4242424242424242",
        :exp_month => 11,
        :exp_year => 2014,
        :cvc => 123
      }
    )

    response['tag'][0..3].must_equal "cus_"
  end

   it "must list created customers" do
    response = White::Customer.all()
    response.wont_be_empty
   end
 
end