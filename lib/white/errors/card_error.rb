module White
  class CardError < WhiteError

    attr_reader :code

    def initialize(message, code, http_status=nil)
      super(message, http_status)
      @code = code
    end
  end
end 