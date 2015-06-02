module Fluent
  class PrestoQueryInput < Fluent::Input
    Plugin.register_input 'presto_query', self

    # Define `router` method of v0.12 to support v0.10 or earlier
    unless method_defined?(:router)
      define_method("router") { Fluent::Engine }
    end

    config_param :tag, :string
    config_param :sql, :string
    config_param :host, :string
    config_param :port, :integer, default: 8080
    config_param :user, :string, default: 'fluentd'
    config_param :schema, :string, default: 'default'
    config_param :catalog, :string, default: 'native'
    config_param :interval, :time, default: '30m' # not use.
    config_param :cron, :string, default: '0 0 * * *'

    def configure(conf)
      require 'presto-client'
      require 'parse-cron'
      super
    end

    def start
      @cron_parser = CronParser.new(@cron)
      @client = Presto::Client.new(
        server: "#{@host}:#{@port}",
        catalog: @catalog,
        user: @user,
        schema: @schema
      )
      @thread = Thread.new(&method(:run))
    end

    def shutdown
      Thread.kill(@thread)
    end

    def run
      loop do
        secs = @cron_parser.next(Time.now) - Time.now
        log.info "next query at #{@cron_parser.next(Time.now)}. Sleep #{secs}seconds."
        sleep secs
        Thread.new(&method(:emit_presto_query))
      end
    end

    def emit_presto_query
      begin
        log.info "sql [#{@sql}]"
        records = exec_query(@sql)
        records.each do |record|
          router.emit @tag, Fluent::Engine.now, record
        end
      rescue => e
        log.error e
      end
    end

    private
    def exec_query(query)
      return if query.nil? || query.empty?
      @client.query(query) do |q|
        columns = q.columns.map {|column|
          column.name
        }

        results = []
        q.each_row {|row|
          results << columns.each_with_index.inject({}) {|result, (column_name, i)| 
            result[column_name] = row[i]
            result
          }
        }
        return results
      end
    end
  end
end
