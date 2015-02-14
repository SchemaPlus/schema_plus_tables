require 'schema_plus/core'

require_relative 'tables/version'

# Load any mixins to ActiveRecord modules, such as:
#
#require_relative 'tables/active_record/base'

# Load any middleware, such as:
#
# require_relative 'tables/middleware/model'

SchemaMonkey.register SchemaPlus::Tables
