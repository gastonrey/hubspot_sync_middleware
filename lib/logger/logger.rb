require 'logger'

module Log
  extend self

  # LOG_FILE = '../log/logs.log'

  def logger
    logger ||= Logger.new(STDOUT)
    logger.level = Logger::DEBUG
    logger
  end
end
