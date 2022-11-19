require "byebug"

module Services
  module HubspotSync
    module_function

    ##
    # @param data [Array]: 
    #     Contains the data storaged [db1_storage, db2_storage]
    #
    def start(data)
      db1_entities = data.find { |v| v.name == "db1" }
      db2_entities = data.find { |v| v.name == "db2" }

      merged_data = remove_duplicates(db1_entities, db2_entities)

      # IMPORTANT: This is part of a POC, so lets store the output
      # in a file, so it can be inspected by the team before procceding with HS updates
      File.open("./output/hubspot_filtered_data.json", 'w') do |f|
        f.write(merged_data.to_json)
      end

      ##
      # Given we alreay have the data merged and completed
      # here we could connect to HS by going through our list
      # As mentioned in the README this step would be more helpful
      # If this merged data is sent as messages to a queue and then multiple
      # consumers would take it, try to retrieve given contact from HS and 
      # replace the given contact with the one coming from our sync system
      merged_data
    end

    def remove_duplicates(db1, db2)
      db1.entities.map! do |entity|
        unless entity.nil?
          # byebug if db2[entity].last.nil?
          index, result = db2[entity]
          if result
            index_db1, result_db_1 = db1[entity]
            db2.entities.delete_at(index)

            result_db_1.to_h.merge(result.to_h) { |_, o, n| 
              [o, n].flatten
                .uniq
                .compact
                .max 
            }
          end
        end
      end

      db1.to_h.append(db2.to_h).flatten!
    end

    def add_max_mrr(values)
      values.map(&:to_i).max
    end
  end
end