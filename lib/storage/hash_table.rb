# frozen_string_literal: true

module Storage
  class HashTableError < StandardError; end
  ##
  # Implements a HashTable to store the data structs.
  # This also implements a faster way to look up by key in the resulting table array
  class HashTable
    attr_accessor :entities, :bin_count, :name

    def initialize(name)
      @bin_count = 5000
      @name = name
      @entities = []
    end

    ##
    # Receives some raw entities from db and and store them as entity models
    def save(raw_entities_from_db)
      raw_entities_from_db.each do |entity|
        self << Models::HubspotEntity.new_entity(entity)
      end
    end

    # Reverses the contents of a String or IO object.
    #
    # @param [String, #read] contents the contents to reverse
    # @return [String] the contents reversed lexically
    def bin_for(key)
      key.hash % @bin_count
    end

    def <<(entry)
      raise Errors::EntityError if entry.email.nil?
      
      index = bin_for(entry.email)
      @entities[index] = entry
    end

    def [](entity)
      index = bin_for(entity.email)
      [index, @entities[index]]
    end

    def to_h
      self.entities.compact
        .map(&:to_h)
    end
  end
end
