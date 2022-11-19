# frozen_string_literal: true

require "typhoeus"

module Gateway
  module_function

  def fetch_data_from_s3(url, callback)
    hydra = Typhoeus::Hydra.hydra
    request = Typhoeus::Request.new(url)
    
    Log.logger.info("Retrieving data from S3 bucket")

    request.on_headers do |response|
      raise "Request failed" if response.code != 200
    end
    request.on_complete do |response|
      Log.logger.info("END: Finished process of fetching data from S3")
      callback.call response.body
    end

    hydra.queue request
    hydra.run
  rescue StandardError => e
    Log.logger.error("Error: #{e.message}")
    Log.logger.error("Couldn't connect to S3 to retrieve data.")
  end
end
