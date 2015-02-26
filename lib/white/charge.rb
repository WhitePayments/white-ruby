module White
  class Charge

    def self.create(params={})
      White.post(White.api_url('charges/'), params)
    end

    def self.get(id)
      White.get(White.api_url('charges/' + id.to_s))
    end

    def self.all
      White.get(White.api_url('charges/'))
    end

  end
end
