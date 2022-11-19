RSpec.describe 'Services::HubspotSync' do
  describe 'When data is duplicated (same email) or some fields are not completed' do
    let(:db1_t) { "db1" }
    let(:db2_t) { "db2" }

    let(:db1) do
      Storage::HashTable.new(db1_t)
    end

    let(:db2) do
      Storage::HashTable.new(db2_t)
    end

    let(:create_duplicated_entites) do
      raw_entity1 = {
        "name": "Carole Ratke",
        "country": "FR",
        "phone": "+33 02 67 12 09 99",
        "mrr": 22,
        "email": "foo1",
        "company_size": 148
      }

      raw_entity2 = {
        "name": "Carole Ratke",
        "country": "ES",
        "phone": "+33 02 67 12 09 99",
        "mrr": 2290,
        "email": "foo1",
        "company_name": "C1"
      }
      db1.save([JSON.parse(raw_entity1.to_json)])
      db2.save([JSON.parse(raw_entity2.to_json)])
    end

    subject(:result) { 
      create_duplicated_entites
      Services::HubspotSync.start([db1, db2])
    }

    it "then email is correct" do
       expect(result.first[:email]).to eq "foo1"
    end

    it "then objects are merged into one" do
       expect(result.size).to eq 1
    end

    it "then company_name is added" do
       expect(result.first[:company_name]).to eq "C1"
    end

    it "then mrr taken is the highest one" do
       expect(result.first[:mrr]).to eq 2290
    end

    it "then company size remains" do
       expect(result.first[:company_size]).to eq 148
    end

    
      # expect(result.first[:company_name]).to eq "C1"
      # expect(result.first[:company_size]).to eq 148
      # expect(result.first[:mrr]).to eq 2290
  end
end