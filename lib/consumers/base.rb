# frozen_string_literal: true

class ErrorProcessingJSONData < StandardError; end

module Consumers
  class Base
    def perform
      raise NotImplementedError, "Method should be implemented"
    end
  end
end
