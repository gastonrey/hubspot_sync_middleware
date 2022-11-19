# frozen_string_literal: true

module Errors
  module_function

  def logger
    @logger ||= Slogger.new.log
  end

  class EntityError < StandardError
    def initialize
      Log.logger.error("Created entities should have email, mandatory field")
    end
  end
end
