
Pod::Spec.new do |s|
  s.name             = 'NetworkService'
  s.version          = '0.1.0'
  s.summary          = 'Just a simple network service with URLSession and Reactive programming'

  s.description      = <<-DESC 
  If you have any questions just email me raikonen@me.com or via telegram: @sirsviblovo
                       DESC

  s.homepage         = 'https://github.com/KrockodilL/NetworkService'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'KrockodilL' => 'raikonen@me.com' }
  s.source           = { :git => 'https://github.com/KrockodilL/NetworkService.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/sirsviblovo'

  s.ios.deployment_target = '11.0'

  s.source_files = 'NetworkService/Classes/**/*'
  
  # s.resource_bundles = {
  #   'NetworkService' => ['NetworkService/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'RxCocoa'
   s.dependency 'RxSwift'
end
