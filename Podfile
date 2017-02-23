# Uncomment the next line to define a global platform for your project
 platform :ios, '8.0'

target 'Appility' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Appility
    pod 'SwiftyJSON', :git => 'https://github.com/SwiftyJSON/SwiftyJSON.git', :branch => 'swift2'
    
    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |configuration|
                configuration.build_settings['SWIFT_VERSION'] = "2.3"
            end
        end
    end
end
