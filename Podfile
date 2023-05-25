# Uncomment the next line to define a global platform for your project
source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'

platform :ios, '12.0'

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['CODE_SIGN_IDENTITY'] = ''
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = 12.0
      end
    end
  end
end

target 'Awesome Calendar' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  # Pods for Awesome Calendar
  pod 'FSCalendar'
  pod 'SnapKit', '~> 4.0'

  target 'Awesome CalendarTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Awesome CalendarUITests' do
    # Pods for testing
  end

end
