# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name          = "fluent-plugin-presto_query"
  gem.version       = "0.0.3"
  gem.summary       = %q{Fluentd Input plugin to execute Presto query and fetch rows.}
  gem.description   = %q{Fluentd Input plugin to execute Presto query and fetch rows.}
  gem.license       = "MIT"
  gem.authors       = ["Hiroshi Toyama"]
  gem.email         = "toyama0919@gmail.com"
  gem.homepage      = "https://github.com/toyama0919/fluent-plugin-presto_query"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_runtime_dependency "presto-client"
  gem.add_runtime_dependency "parse-cron"
  gem.add_development_dependency 'bundler', '~> 1.7.2'
  gem.add_development_dependency 'fluentd', '~> 0.10.60'
  gem.add_development_dependency 'pry', '~> 0.10.1'
  gem.add_development_dependency 'rake', '~> 10.3.2'
  gem.add_development_dependency 'rubocop', '~> 0.24.1'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'
  gem.add_development_dependency 'yard', '~> 0.8'
end
