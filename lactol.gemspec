# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "lactol"
  spec.version       = File.read(File.join("VERSION", File.dirname(__FILE__))).chomp
  spec.authors       = ["okitan"]
  spec.email         = ["okitakunio@gmail.com"]
  spec.summary       = "web interface for thor executables"
  spec.description   = "web interface for thor executables"
  spec.homepage      = "https://github.com/okitan/lactol"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
