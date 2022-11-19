Dir[File.expand_path("./lib/**/*.rb")].each { |file| require file }

producer = Producers::S3.new
storages = producer.perform

##
# This Service will produce an output file in ./output for testing purpose
#
Services::HubspotSync.start(storages)
