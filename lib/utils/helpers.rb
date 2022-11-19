require "yaml"
require 'erb'

module Helpers
  module_function

  def load_configuration
    path = Dir[File.expand_path("./config/**/config.yml")].first
    return {} unless path

    raw_yaml = File.open(path).read
    content = ERB.new(raw_yaml).result
    parsed_config = YAML.safe_load(content, [], [], true)
    parsed_config[ENV.fetch('RACK_ENV', 'development')]
  rescue Errno::ENOENT
    raise "Could not load YAML file: #{path}"
  end
end