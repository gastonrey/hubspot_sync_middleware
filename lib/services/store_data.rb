# frozen_string_literal: true

require "json"

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
      parsed.each do |element|
        element["email"]&.downcase!
      end
    end
  end
end
