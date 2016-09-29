#
# Be sure to run `pod lib lint AppNotice.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AppNotice'
  s.version          = '2.1.8'
  s.summary          = 'AppNotice lets you inform your users which third party SDKs your app is using.'
  s.description      = <<-DESC
AppNotice lets you inform your users which third party SDKs your app is using. It lets the user opt out of using any optional SDKs like usage analytics, for example. It also records whether a consent notice has been shown, accepted, declined, etc.
                       DESC

  s.homepage         = 'https://www.ghostery.com/our-solutions/ghostery-privacy/for-your-brands/'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.source           = { :git => 'https://github.com/ghostery/AppNoticeSDK-iOS.git', :tag => s.version.to_s }
  s.author           = { 'Joe Swindler' => 'jswindler@ghostery.com' }
  s.social_media_url = 'https://twitter.com/Ghostery'

  s.ios.deployment_target = '8.1'
  s.frameworks = 'UIKit', 'Foundation'
  s.vendored_frameworks = 'AppNotice/AppNoticeSDKFramework.framework'
  s.resources = 'AppNotice/AppNotice.bundle'
  s.module_map = 'AppNotice/module.modulemap'
end
