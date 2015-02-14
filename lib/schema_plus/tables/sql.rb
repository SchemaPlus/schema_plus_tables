module SchemaPlus::Tables
  module Sql

    def self.drop_table(env, support_temporary:, support_cascade:)
      sql = "DROP"
      sql += ' TEMPORARY' if env.options[:temporary] and support_temporary
      sql += " TABLE"
      sql += " IF EXISTS" if env.options[:if_exists]    # added by schema_plus
      sql += " #{env.connection.quote_table_name(env.table_name)}"
      sql += " CASCADE" if env.options[:force] == :cascade and support_cascade
      sql
    end
  end
end
