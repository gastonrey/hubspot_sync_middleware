class ErrorProcessingJSONData < StandardError; end

module Producers
  class Base
    def perform
      raise NotImplementedError, 'Method should be implemented'
    end
  end
end
