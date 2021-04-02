lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative 'lib/clint/version'

Gem::Specification.new do |spec|
  spec.name          = "clint"
  spec.version       = Clint::VERSION
  spec.authors       = ["Bryn Bayliss"]
  spec.email         = ["brynbayliss@hotmail.com"]

  spec.summary       = %q{Ruby gem, to check if any gems defined in your gemfile contain C extensions}
  spec.homepage      = "https://github.com/brynbayliss87"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
#  spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
#  spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = ["clint"]
  spec.require_paths = ["lib"]
  spec.add_development_dependency 'pry'
  spec.add_dependency 'minitar'
end
