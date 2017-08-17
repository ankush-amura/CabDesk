module ExceptionHandling
  class NumberError < StandardError
    def initialize
      @message = "Digits In Name Are UnAcceptable"
    end
  end

  class AlphaError < StandardError
    def initialize
      @message = "The Age Should Not contain the Alphabets"
    end
  end
end
