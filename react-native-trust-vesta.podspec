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
  s.license      = "MIT"
  s.authors      = { "Kenneth Jiang" => "kenneth@fluz.app" }
  s.platforms    = { :ios => "9.0" }
  s.source       = { :git => "https://github.com/StronkMan/react-native-trust-vesta.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,c,m,swift}"
  s.requires_arc = true
  s.xcconfig = { 
    'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/../../node_modules/@fluzclient/react-native-trust-vesta/ios/Frameworks/"',
    'VALID_ARCHS' => '"arm64 arm64e"'
  }
  s.dependency "React"
end

