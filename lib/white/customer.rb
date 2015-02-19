module White
  class Customer

    def self.create(params={})
      White.post(White.api_url('customers/'), params)
    end

    def self.get(id)
      White.get(White.api_url('customers/' + id.to_s))
    end
    
    def self.all
      White.get(White.api_url('customers/'))
    end

  end
end
