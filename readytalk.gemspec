Gem::Specification.new do |s|
  s.name = 'readytalk'
  s.version = '0.6.2'
  s.date = '2016-01-19'
  s.summary = "Ruby binding for the ReadyTalk API"
  s.description = "Ruby binding for the ReadyTalk API - A web conferencing platform."
  s.authors = ["Mike Pogran"]
  s.email  = ['mike@ellevatenetwork.com']
  s.license = 'MIT'
  s.homepage = 'https://github.com/ellevate/readytalk'

  s.add_dependency('rest-client', '>= 1.4', '< 4.0')
  s.add_dependency('json', '~> 1.8')

  s.files = `git ls-files`.split("\n")
end
