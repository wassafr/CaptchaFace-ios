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
  s.version          = "0.9"
  s.summary          = "The mobile visual captcha"
  s.description      = <<-DESC
                       An optional longer description of CaptchaFace

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/wassafr/CaptchaFace-ios"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'COMMERCIAL'
  s.author           = { "wassa" => "contact@wassa.fr" }
  s.source           = { :git => "https://github.com/wassafr/CaptchaFace-ios.git", :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.resources = ['Pod/Assets/*']

  s.public_header_files = 'Pod/Headers/*.h'
  s.vendored_libraries= 'Pod/lib/libWtfSDK.a'
  s.dependency 'OpenCV', '~> 2.4'
end
