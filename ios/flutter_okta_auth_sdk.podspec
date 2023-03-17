#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_okta_auth_sdk.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_okta_auth_sdk'
  s.version          = '0.0.4'
  s.summary          = 'This Flutter Okta Auth SDK library helps you to add authentication in your Flutter apps. It is a wrapper around Okta Android and Okta iOS.'
  s.description      = <<-DESC
A new Flutter project.
                       DESC
  s.homepage         = 'https://github.com/shivbo96/flutter_okta_auth_sdk'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Shivam Mishra ' => 'mishra.shivam1311@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'OktaOidc'
  s.dependency 'OktaJWT'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
