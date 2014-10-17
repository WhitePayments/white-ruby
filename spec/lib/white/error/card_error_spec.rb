require_relative '../../../spec_helper'

describe White::CardError do
 
  it "must be thown with card_declined" do
    White.api_key = "sk_test_1234567890abcdefghijklmnopq"

    begin
      response = White::Charge.create(
        :amount => 400,
        :currency => "usd",
        :card => {
          :number => "4000000000000002",
          :exp_month => 11,
          :exp_year => 2014,
          :cvv => 123
        },
        :description => "Charge for test@example.com"
      )
    rescue White::CardError => e
      e.code.must_equal 'card_declined'
      e.http_status.must_equal 400
    end
  end

  it "must be thown with invalid_cvc" do
    White.api_key = "sk_test_1234567890abcdefghijklmnopq"

    begin
      response = White::Charge.create(
        :amount => 400,
        :currency => "usd",
        :card => {
          :number => "4000000000000127",
          :exp_month => 11,
          :exp_year => 2014,
          :cvv => 123
        },
        :description => "Charge for test@example.com"
      )
    rescue White::CardError => e
      e.code.must_equal 'invalid_cvc'
      e.http_status.must_equal 400
    end
  end

  it "must be thown with expired_card" do
    White.api_key = "sk_test_1234567890abcdefghijklmnopq"

    begin
      response = White::Charge.create(
        :amount => 400,
        :currency => "usd",
        :card => {
          :number => "4000000000000069",
          :exp_month => 11,
          :exp_year => 2014,
          :cvv => 123
        },
        :description => "Charge for test@example.com"
      )
    rescue White::CardError => e
      e.code.must_equal 'expired_card'
      e.http_status.must_equal 400
    end
  end

  it "must be thown with processing_error" do
    White.api_key = "sk_test_1234567890abcdefghijklmnopq"

    begin
      response = White::Charge.create(
        :amount => 400,
        :currency => "usd",
        :card => {
          :number => "4000000000000119",
          :exp_month => 11,
          :exp_year => 2014,
          :cvv => 123
        },
        :description => "Charge for test@example.com"
      )
    rescue White::CardError => e
      e.code.must_equal 'processing_error'
      e.http_status.must_equal 400
    end
  end

  it "must be thown with invalid_card" do
    White.api_key = "sk_test_1234567890abcdefghijklmnopq"

    begin
      response = White::Charge.create(
        :amount => 400,
        :currency => "usd",
        :card => {
          :number => "1234123412341234",
          :exp_month => 11,
          :exp_year => 2014,
          :cvv => 123
        },
        :description => "Charge for test@example.com"
      )
    rescue White::CardError => e
      e.code.must_equal 'invalid_card'
      e.http_status.must_equal 400
    end
  end

  it "must be thown with invalid_expiry_month" do
    White.api_key = "sk_test_1234567890abcdefghijklmnopq"

    begin
      response = White::Charge.create(
        :amount => 400,
        :currency => "usd",
        :card => {
          :number => "4242424242424242",
          :exp_month => 15,
          :exp_year => 2014,
          :cvv => 123
        },
        :description => "Charge for test@example.com"
      )
    rescue White::CardError => e
      e.code.must_equal 'invalid_expiry_month'
      e.http_status.must_equal 400
    end
  end

  it "must be thown with invalid_expiry_year" do
    White.api_key = "sk_test_1234567890abcdefghijklmnopq"

    begin
      response = White::Charge.create(
        :amount => 400,
        :currency => "usd",
        :card => {
          :number => "4242424242424242",
          :exp_month => 12,
          :exp_year => 2100,
          :cvv => 123
        },
        :description => "Charge for test@example.com"
      )
    rescue White::CardError => e
      e.code.must_equal 'invalid_expiry_year'
      e.http_status.must_equal 400
    end
  end
end