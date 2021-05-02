lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative 'lib/blondie/version'

Gem::Specification.new do |spec|
  spec.name          = "blondie"
  spec.version       = Blondie::VERSION
  spec.authors       = ["Bryn Bayliss"]
  spec.email         = ["brynbayliss@hotmail.com"]

  spec.summary       = %q{Ruby gem, to check if any gems defined in your gemfile contain C extensions}
  spec.homepage      = "https://github.com/brynbayliss87/blondie"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata['allowed_push_host'] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = ["blondie"]
  spec.require_paths = ["lib"]
  spec.add_development_dependency 'pry'
  spec.add_dependency 'minitar', '~> 0.9'
end
