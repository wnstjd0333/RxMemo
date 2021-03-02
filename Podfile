# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'RxMemo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for RxMemo
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Action'
  pod 'NSObject+Rx'
  pod 'RxDataSources'
  pod 'RxCoreData'
end

deployment_target = '10.0'

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
            end
        end
        project.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
        end
    end
end
