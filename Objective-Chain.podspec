Pod::Spec.new do |s|
  s.name         = "Objective-Chain"
  s.version      = "0.2.0"
  s.summary      = "A short description of Objective-Chain."

  s.description  = "Objective-Chain"

  s.homepage     = "https://github.com/go886/Objective-Chain"
  s.license      = "MIT"
  s.author       = { "rz.li" => "rz.li@alibaba-inc.com" }
 

  s.source       = { :git => "https://github.com/go886/Objective-Chain.git", :tag => "0.2.0" }
  s.requires_arc = true
  s.source_files = "Sources", "Sources/**/*.{h,m}"
  s.platform     = :ios, '5.0'
end
