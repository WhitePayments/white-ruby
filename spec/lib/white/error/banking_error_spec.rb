require_relative '../../../spec_helper'

describe White::BankingError do
 
  it "must be thown with card_declined" do
    White.api_key = "test_sec_k_25dd497d7e657bb761ad6"

    begin
      response = White::Charge.create(
        :amount => 400,
        :currency => "usd",
        :card => {
          :number => "4000000000000002",
          :exp_month => 11,
          :exp_year => 2016,
          :cvc => 123
        },
        :description => "Charge for test@example.com"
      )
    rescue White::BankingError => e
      e.code.must_equal 'card_declined'
      e.http_status.must_equal 402
    end
  end
  
end
