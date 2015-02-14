module SchemaPlus::Tables
  module Middleware

    module Migration
      module DropTable

        def before(env)
          if env.options[:cascade]
            ActiveSupport::Deprecation.warn "drop_table option `cascade: true` is deprecated, use `force: :cascade` instead"
            env.options[:force] = :cascade
          end
        end

        module Mysql
          def implement(env)
            env.connection.execute Sql.drop_table(env, support_temporary: true, support_cascade: true)
          end
        end
        
        module Postgresql
          def implement(env)
            env.connection.execute Sql.drop_table(env, support_temporary: false, support_cascade: true)
          end
        end
        
        module Sqlite3
          def implement(env)
            env.connection.execute Sql.drop_table(env, support_temporary: false, support_cascade: false)
          end
        end

      end
    end
  end
end
