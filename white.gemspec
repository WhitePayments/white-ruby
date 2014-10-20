$:.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'white/version'

spec = Gem::Specification.new do |s|
  s.name = 'white_payments'
  s.version = White::VERSION
  s.summary = 'Ruby bindings for the White API'
  s.description = 'White is the easiest way to accept payments online in the middle east. See https://whitepayments.com for details.'
  s.authors = ['Yazin Alirhayim','Sebastian Choren']
  s.email = ['yazin@whitepayments.com']
  s.homepage = 'https://whitepayments.com/docs/'
  s.license = 'MIT'

  s.add_dependency('httparty', '~> 0.13')
  s.add_dependency('json', '~> 1.8.1')

  s.add_development_dependency('minitest', '~> 4.7.5')
  s.add_development_dependency('turn', '~> 0.9.7')
  s.add_development_dependency('rake')

  s.files = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ['lib']
end
