require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-trust-vesta"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  react-native-trust-vesta
                   DESC
  s.homepage     = "https://github.com/StronkMan/react-native-trust-vesta"
  # brief license entry:
  s.license      = "MIT"
  # optional - use expanded license entry instead:
  # s.license    = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { "Kenneth Jiang" => "kenneth@fluz.app" }
  s.platforms    = { :ios => "9.0" }
  s.source       = { :git => "https://github.com/StronkMan/react-native-trust-vesta.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,c,m,swift}"
  s.requires_arc = true
  # s.vendored_frameworks = 'ios/Frameworks/DataCollector.framework'
  # s.vendored_frameworks = 'ios/Frameworks/TMXProfiling.framework'
  # s.vendored_frameworks = 'ios/Frameworks/TMXProfilingConnections.framework'
  s.dependency "React"
  # ...
  # s.dependency "..."
end

