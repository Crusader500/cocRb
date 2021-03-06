# frozen_string_literal: true

require_relative "lib/cocRb/version"

Gem::Specification.new do |spec|
  spec.name          = "cocRb"
  spec.version       = CocRb::VERSION
  spec.authors       = ["Crusader123"]
  spec.email         = ["crazyboy15october@gmail.com"]
  spec.summary       = "A Gem for interacting with the Clash of Clans API easily!"
  spec.files         = Dir["LICENSE", "README.md", "Rakefile", "lib/**/*"]
  spec.homepage      = "https://github.com/Crusader500/cocRb"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.4.0"



   spec.bindir        = "exe"
   spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
   spec.require_paths = ["lib"]

   spec.add_development_dependency "rake", "~> 10.0"
   spec.add_development_dependency "rspec", "~> 3.0"
   spec.add_development_dependency "rdoc", "~> 6.3.1"


   spec.add_dependency "faraday", "~> 1.4.1"
   spec.add_dependency "json", "~> 2.5.1"
   spec.add_dependency "time", "~> 0.1.0"

end
