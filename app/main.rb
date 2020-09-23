require 'active_record'
require_relative './models/money'
require_relative './models/product'
require_relative './transaction'

def db_configuration
  db_configuration_file = File.join(File.expand_path(__dir__), '..', 'db', 'config.yml')
  YAML.load(File.read(db_configuration_file))
end

ActiveRecord::Base.establish_connection(db_configuration['development'])
