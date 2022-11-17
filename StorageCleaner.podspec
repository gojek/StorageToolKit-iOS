Pod::Spec.new do |s|
  s.name             = "StorageCleaner"
  s.version          = "0.9.0"
  s.summary          = "StorageCleaner is a declarative disk cleaning utitlity"
  s.description      = "StorageCleaner deletes files and other objects according to declarative configuration"

  s.homepage         = 'https://github.com/gojek/StorageToolKit-iOS/tree/main/StorageCleaner'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  
  s.author           = "Gojek"
  s.source           = { :git => '' }

  s.platform         = :ios
  s.ios.deployment_target = '11.0'
  s.swift_version    = '5.0'

  s.source_files  = 'StorageCleaner/Sources/**/*.swift'
  s.dependency 'WorkManager', '~> 0.9.0'
end
