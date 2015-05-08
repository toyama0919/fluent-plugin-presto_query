require 'helper'

class PrestoQueryInputTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  def create_driver(conf)
    Fluent::Test::InputTestDriver.new(Fluent::PrestoQueryInput).configure(conf)
  end

  def test_configure_full
    d = create_driver %q{
      tag test
      interval 10m
      sql select * from hoge
      host presto-cordinator
    }

    assert_equal 'test', d.instance.tag
    assert_equal 10 * 60, d.instance.interval
    assert_equal 'select * from hoge', d.instance.sql
    assert_equal 'presto-cordinator', d.instance.host
  end

  def test_configure_error_when_config_is_empty
    assert_raise(Fluent::ConfigError) do
      create_driver ''
    end
  end
end