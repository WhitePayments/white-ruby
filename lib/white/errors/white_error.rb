module White
  class WhiteError < StandardError
    attr_reader :message
    attr_reader :code
    attr_reader :http_status

    def initialize(message=nil, code=nil, http_status=nil)
      @message = message
      @code = code
      @http_status = http_status
    end

    def to_s
      status_string = @http_status.nil? ? "" : "(#{@code}Error - Status #{@http_status}) "
      "#{status_string}#{@message}"
    end
  end
end