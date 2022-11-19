RSpec.describe 'Producers::S3' do
  context 'When a new request is done to DBs' do
    response = Typhoeus::Response.new(code: 200, body: [{
        "name": "Carole Ratke",
        "country": "FR",
        "phone": "+33 02 67 12 09 99",
        "mrr": 227,
        "email": "fake_email",
        "company_size": 148
      }].to_json)
    Typhoeus.stub(/https:\/\/s3.us-west-2.amazonaws.com/).and_return(response)

    it 'Then it returns an array with [storage_db1, storage_db2]' do
      result = Producers::S3.new.perform
      
      expect(result.first.name).to eq "db1"
      expect(result.last.name).to eq "db2"
    end
  end

  context 'When error occur during process' do
    it 'Then raise a ProducerError with message' do 
      allow(Helpers).to receive(:load_configuration).and_return(nil)

      expect { Producers::S3.new.perform }.to raise_error(Producers::ProducerError, /Error/)
    end
  end
end