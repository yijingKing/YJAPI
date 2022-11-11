

Pod::Spec.new do |s|
  s.name             = 'YJAPI'
  s.version          = '0.0.4'
  s.summary          = 'A short description of YJAPI.'

  s.description      = <<-DESC
                        YJAPI
                       DESC

  s.homepage         = 'https://github.com/1091676312@qq.com/YJAPI'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '╰莪呮想好好宠Nǐつ' => '1091676312@qq.com' }
  s.source           = { :git => 'https://github.com/yijingKing/YJAPI.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.swift_versions   = '5.0'
  
  s.source_files = 'YJAPI/Classes/**/*'
  
  # s.resource_bundles = {
  #   'YJAPI' => ['YJAPI/Assets/*.png']
  # }
  
  s.dependency 'Alamofire','~>5.6.2'
  
  
  
  
  
end
