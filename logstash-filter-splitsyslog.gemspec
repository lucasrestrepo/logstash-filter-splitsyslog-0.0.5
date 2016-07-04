Gem::Specification.new do |s|
  s.name = 'logstash-filter-splitsyslog'
  s.version         = '0.0.5'
  s.licenses = ['Apache License (2.0)']
  s.summary = "This filter splits the key value pair from the structured syslog."
  s.description = "This gem is a logstash plugin required to be installed on top of the Logstash core pipeline using $LS_HOME/bin/plugin install gemname. This gem is not a stand-alone program, package also contains, modified syslog input and unmodified syslog output filters"
  s.authors = ["Ahzam Ali"]
  s.email = 'ahzam@juniper.net'
  s.homepage = "http://www.elastic.co/guide/en/logstash/current/index.html"
  s.require_paths = ["lib"]

  # Files
  # find all files in the current directory make them part of the bundle
  s.files = `find . -type f`.split($\)
  # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "filter" }

  # Gem dependencies
  s.add_runtime_dependency "logstash-core", '>= 1.5.0', '< 2.0.0'
  s.add_development_dependency 'logstash-devutils'
end
