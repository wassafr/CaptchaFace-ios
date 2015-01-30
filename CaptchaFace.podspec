#
# Be sure to run `pod lib lint CaptchaFace.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "CaptchaFace"
  s.version          = "1.0.1"
  s.summary          = "Captchaface SDK reinvents mobile security by ensuring users of an app are real."
  s.homepage         = "https://github.com/wassafr/CaptchaFace-ios"
  s.license          = 'COMMERCIAL'
  s.author           = { "wassa" => "contact@wassa.fr" }
  s.source           = { :git => "https://github.com/wassafr/CaptchaFace-ios.git", :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.resources = ['Pod/Assets/*']

  s.source_files = 'Pod/Headers/*.h'
  s.public_header_files = 'Pod/Headers/*.h'
  s.vendored_libraries= 'Pod/lib/libWtfSDK.a'
  s.dependency 'OpenCV', '~> 2.4'
end
