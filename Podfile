

target 'HeroExamples' do
  platform :ios, '12.0'
  use_frameworks!
  pod 'CollectionKit', :inhibit_warnings => true

  target 'HeroTests' do
    inherit! :search_paths
  end
end

target 'HeroTvOSExamples' do
  platform :tvos, '12.0'
  use_frameworks!
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 12.0
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      end
      if config.build_settings['TVOS_DEPLOYMENT_TARGET'].to_f < 12.0
        config.build_settings['TVOS_DEPLOYMENT_TARGET'] = '12.0'
      end
    end
  end
end
