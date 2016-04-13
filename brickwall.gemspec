$LOAD_PATH.unshift 'lib'
require 'brickwall/version'

Gem::Specification.new do |s|
  s.name          = 'brickwall'
  s.version       = Brickwall::VERSION
  s.date          = Time.now.strftime('%Y-%m-%d')
  s.summary       = 'Unofficial Paymentwall Brick API wrapper'
  s.description   = s.summary
  s.homepage      = 'http://github.com/sujrd/brickwall'
  s.authors       = ['Douglas Teoh']
  s.email         = 'douglas@dteoh.com'
  s.has_rdoc      = false
  s.files         = `git ls-files -z`.split("\x0")
  s.require_paths = %w(lib)
  s.license       = 'MIT'
end
