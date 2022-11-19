module Consumers
  class ConsumersError < StandardError; end
  ##
  # Consumes data storaged in mem HashTables
  class HashTableStorages < Base
    ##
    # Performs the merge between dbs and returns curated data
    # before sync with HS
    def perform(storages)
      Services::HubspotSync.start(storages)
    rescue StandardError
      raise ConsumersError.new("Error trying to perform...")
    end
  end
end
