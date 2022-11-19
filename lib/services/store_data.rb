require 'json'

module Services
  module Store
    module_function

    ##
    # Given a storage and the data perform the save on storage
    def on(storage, data)
      storage.save(parse_and_normalize(data))
    end

    def parse_and_normalize(data)
      parsed = JSON.parse(data)
      parsed.each { |element| 
        element["email"].downcase! unless element["email"].nil? 
      }
    end
  end
end