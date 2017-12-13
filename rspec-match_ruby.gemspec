
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'rspec-match_ruby'
  spec.version       = '0.1.1'
  spec.authors       = ['winebarrel']
  spec.email         = ['sugawara@winebarrel.jp']

  spec.summary       = %q{Ruby code matcher.}
  spec.description   = %q{Ruby code matcher.}
  spec.homepage      = 'https://github.com/winebarrel/rspec-match_ruby'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rspec', '~> 3'
  spec.add_dependency 'parser'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
end
