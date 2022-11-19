RSpec.describe 'Storage::HashTable' do
  context 'When a new instance is created with name' do
    let(:table_name) { "foo" }

    let(:fake_email) { "foo@bar" }

    let(:hash_table) do
      Storage::HashTable.new(table_name)
    end

    let(:create_new_entity) do
      raw_entity = {
        "name": "Carole Ratke",
        "country": "FR",
        "phone": "+33 02 67 12 09 99",
        "mrr": 227,
        "email": fake_email,
        "company_size": 148
      }
      hash_table.save([JSON.parse(raw_entity.to_json)])
    end

    let(:create_new_entity_without_email) do
      raw_entity = {
        "name": "Carole Ratke",
        "country": "FR",
        "phone": "+33 02 67 12 09 99",
        "mrr": 227,
        "email": nil,
        "company_size": 148
      }
      hash_table.save([JSON.parse(raw_entity.to_json)])
    end

    it 'Then it has a given name' do
      expect(hash_table.name).to match table_name
    end

    it 'Then when a new entity is added it can be found by email field' do
      create_new_entity
      expect(hash_table.entities.last).not_to be_nil
    end

    it 'Then when a new entity is added it can be found by email field' do
      expect do
          create_new_entity_without_email
      end.to raise_error(Errors::EntityError)
    end
  end
end