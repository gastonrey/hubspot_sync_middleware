# frozen_string_literal: true

require "logger"

module Log
  module_function

  # LOG_FILE = '../log/logs.log'

  def logger
    logger ||= Logger.new($stdout)
    logger.level = Logger::DEBUG
    logger
  end
end
