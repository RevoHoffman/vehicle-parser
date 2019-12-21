Gem::Specification.new do |s|
  s.name        = 'vehicle-parser'
  s.version     = '1.1.39'
  s.date        = '2012-04-13'
  s.summary     = "Common vehicle parsers"
  s.description = "Provides common vehicle parsers such as transmission, cylinders, drivetrains"
  s.authors     = ["Mark Hoffman"]
  s.email       = 'markhtexas@gmail.com'
  s.files       = %w( README.md LICENSE HISTORY.md )
  s.files       = Dir.glob("lib/**/*")
  s.add_development_dependency "rspec", ">= 2.0.0"
  s.add_dependency 'activesupport'
  s.add_dependency 'actionpack'
  s.add_dependency 'phone'
end
