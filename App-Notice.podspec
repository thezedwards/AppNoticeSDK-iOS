#
# Be sure to run `pod lib lint App-Notice.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'App-Notice'
  s.version          = '2.0.8.1'
  s.summary          = 'AppNotice lets you inform your users which third party SDKs your app is using.'
  s.description      = <<-DESC
AppNotice (GDPR) lets you inform your users which third party SDKs your app is using. It lets the user opt out of using any optional SDKs like usage analytics, for example. It also records whether a consent notice has been shown, accepted, declined, etc.
                       DESC

  s.homepage         = 'https://www.evidon.com/digital-governance-solutions/site-notice/'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.source           = { :git => 'https://github.com/evidon/AppNoticeSDK-iOS.git', :tag => s.version.to_s }
  s.author           = { 'Evidon by Crownpeak' => 'jake.odowd@crownpeak.com' }
  s.social_media_url = 'https://twitter.com/Evidon'
  s.ios.deployment_target = '8.1'
  s.frameworks = 'UIKit', 'Foundation'
  s.vendored_frameworks = 'AppNotice/AppNoticeSDKFramework.framework'
  s.resources = 'AppNotice/AppNotice.bundle'
  s.module_map = 'AppNotice/module.modulemap'
end
