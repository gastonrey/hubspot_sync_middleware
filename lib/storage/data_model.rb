# frozen_string_literal: true

module Models
  ##
  # Defines a new Struct Entity like:
  # {
  #   name: string
  #   country: 'ES' | 'IT' | 'FR' | 'DE'
  #   email: string
  #   company_size: number
  #   phone: string
  #   mrr: number // Monthly Recurrent Revenue
  # }
  #
  class HubspotEntity
    def self.new_entity(entity)
      model = Struct.new(
        :name,
        :country,
        :email,
        :company_name,
        :company_size,
        :phone,
        :mrr,
        keyword_init: true
      )
      model.new(entity)
    end
  end
end
