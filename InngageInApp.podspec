Pod::Spec.new do |spec|
  spec.name                  = "InngageInApp"
  spec.version               = "1.0.0"
  spec.summary               = "A framework In App Message from Inngage"
  spec.homepage              = "https://inngage.readme.io/docs/ios-sdk#in-app-messages"
  spec.license               = { :type => 'MIT', :file => 'LICENSE' }
  spec.author                = { "Saulo" => "saulo@inngage.com.br" }
  spec.source                = { :git => "https://github.com/inngage/inngage-ios-in-app.git", :tag => "#{spec.version}" }
  spec.ios.deployment_target = "15.0"
  spec.swift_version         = '5.0'
  spec.source_files          = "InngageInApp/**/*.{h,m,swift}"
  spec.frameworks = "Foundation", "UIKit"
  spec.weak_frameworks       = "SwiftUI"
  spec.dependency              "SDWebImageSwiftUI"
end
