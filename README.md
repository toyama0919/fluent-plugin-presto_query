# fluent-plugin-presto_query [![Build Status](https://secure.travis-ci.org/toyama0919/fluent-plugin-presto_query.png?branch=master)](http://travis-ci.org/toyama0919/fluent-plugin-presto_query)

Query to [Presto](https://prestodb.io/) plugin for fluentd

## Examples
```
<source>
  type presto_query
  tag presto_query.exsample
  host presto-cordinator
  catalog store
  schema public
  sql select user_id, count(*) as cnt from db01.schema.conversion where user_id is not null group by user_id having count(*) > 1000
  cron 0 * * * * # You can query at a given time, with cron syntax.
</source>

<match presto_query.exsample>
  type stdout
</match>
```

#### output
```
2015-05-12 16:01:02 +0900 presto_query.exsample: {"user_id":1000,"cnt":3906}
2015-05-12 16:01:02 +0900 presto_query.exsample: {"user_id":2000,"cnt":1348}
2015-05-12 16:01:02 +0900 presto_query.exsample: {"user_id":3000,"cnt":1167}
2015-05-12 16:01:02 +0900 presto_query.exsample: {"user_id":4000,"cnt":1503}
2015-05-12 16:01:02 +0900 presto_query.exsample: {"user_id":5000,"cnt":1689}
2015-05-12 16:01:02 +0900 presto_query.exsample: {"user_id":6000,"cnt":1199}
2015-05-12 16:01:02 +0900 presto_query.exsample: {"user_id":7000,"cnt":1182}
2015-05-12 16:01:02 +0900 presto_query.exsample: {"user_id":8000,"cnt":1079}
2015-05-12 16:01:02 +0900 presto_query.exsample: {"user_id":9000,"cnt":2455}
...
```

## parameter
#TODO

## Installation
```
fluent-gem install fluent-plugin-presto_query
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new [Pull Request](../../pull/new/master)

## Information

* [Homepage](https://github.com/toyama0919/fluent-plugin-presto_query)
* [Issues](https://github.com/toyama0919/fluent-plugin-presto_query/issues)
* [Documentation](http://rubydoc.info/gems/fluent-plugin-presto_query/frames)
* [Email](mailto:toyama0919@gmail.com)

## Copyright

Copyright (c) 2015 Hiroshi Toyama

