require_relative '../../spec_helper'
 
describe White::Charge do
 
  it "must create a new customer" do
    White.api_key = "test_sec_k_25dd497d7e657bb761ad6"

    response = White::Customer.create(
      :name => "Abdullah Ahmed",
      :email => "abdullah@msn.com",
      :card => {
        :number => "4242424242424242",
        :exp_month => 11,
        :exp_year => 2016,
        :cvc => 123
      },
      description => "Signed up at the Trade Show in Dec 2014"
    )

    response['name'].must_equal "Abdullah Ahmed"
  end

   it "must list created customers" do
    response = White::Customer.all()
    response.wont_be_empty
   end
 
end
