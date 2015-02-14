require 'schema_plus/core'

require_relative 'tables/middleware'
require_relative 'tables/sql'
require_relative 'tables/version'

SchemaMonkey.register SchemaPlus::Tables
