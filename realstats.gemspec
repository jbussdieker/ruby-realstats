Gem::Specification.new do |spec|
  spec.name          = "realstats"
  spec.version       = "0.0.1"

  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.files         = `git ls-files`.split($/)

  spec.add_runtime_dependency "bunny"
  spec.add_runtime_dependency "rack"
  spec.add_runtime_dependency "em-websocket"
  spec.add_runtime_dependency "sinatra"
  spec.add_development_dependency "rake"
end
