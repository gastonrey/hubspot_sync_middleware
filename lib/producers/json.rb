module Producers
  class ProducerError < StandardError; end
  ##
  # S3 producer in charge of retrieving data from S3 sources and store it on local tables
  class S3 < Base
    ##
    # Performs the load data from S3 endpoints
    # Returns the created storages and its table names
    def perform
      stores = []

      db_urls = Helpers.load_configuration['S3']
      db_urls.each do |db|
        url = db.last["url"]
        table_name = get_table_name_from(url)
        storage = Storage::HashTable.new(table_name)
        callback = -> (result) { Services::Store.on(storage, result) }
        
        Gateway.fetch_data_from_s3(url, callback)
        stores.push(storage)
      end
            
      stores
    rescue StandardError
      raise ProducerError.new("Error trying to perform...")
    end

    private

    def get_table_name_from(url)
      url.match(/([db]\w+[0-9])\.json/).captures.first
    end
  end
end
