module White
  class Customer

    def self.create(params={})
      White.post(White.api_url('/v1/customers'), params)
    end

    def self.all
      White.get(White.api_url('/v1/customers'))
    end
  end
end