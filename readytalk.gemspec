Gem::Specification.new do |s|
  s.name = 'readytalk'
  s.version = '0.0.1'
  s.date = '2016-01-19'
  s.summary = "Ruby implementation of the ReadyTalk API"
  s.authors = ["Mike Pogran"]
  s.email  = ['mike@ellevatenetwork.com']
  s.license = 'MIT'

  s.add_dependency('rest-client', '~> 1.4')
  s.add_dependency('json', '~> 1.8')

  s.files = `git ls-files`.split("\n")
end
