# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "lactol"
  spec.version       = File.read(File.expand_path("VERSION", File.dirname(__FILE__))).chomp
  spec.authors       = ["okitan"]
  spec.email         = ["okitakunio@gmail.com"]
  spec.summary       = "web interface for thor executables"
  spec.description   = "web interface for thor executables"
  spec.homepage      = "https://github.com/okitan/lactol"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "thor"
  spec.add_runtime_dependency "rack"
  spec.add_runtime_dependency "tilt"
  spec.add_runtime_dependency "slim"

  spec.add_development_dependency "bundler", "~> 1.5"

  # test
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "capybara"

  # travis
  spec.add_development_dependency "rake"

  # develop
  spec.add_development_dependency "pry"
end
