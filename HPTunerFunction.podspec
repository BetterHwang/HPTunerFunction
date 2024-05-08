#
# Be sure to run `pod lib lint HPTunerFunction.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HPTunerFunction'
  s.version          = '0.0.4'
  s.summary          = 'test'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/BetterHwang/HPTunerFunction'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'BetterHwang' => 'hyd0316@vip.qq.com' }
  s.source           = { :git => 'https://github.com/BetterHwang/HPTunerFunction.git', :tag => s.version.to_s }
#  s.source           = { :http => 'https://github.com/BetterHwang/HPTunerFunction/archive/refs/tags/v%s.zip', %s.version}
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
#  s.requires_arc = true
#  s.static_framework = true
  s.ios.deployment_target = '12.0'
#  valid_archs = ['arm64e', 'arm64', 'armv7s', 'armv7']
#  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
#  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.pod_target_xcconfig = { 'VALID_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.source_files = 'HPTunerFunction/Classes/**/*'
  s.public_header_files = 'HPTunerFunction/Classes/*.h'
  
  # s.resource_bundles = {
  #   'HPTunerFunction' => ['HPTunerFunction/Assets/*.png']
  # }
  
  s.frameworks = 'AVFoundation', 'Foundation'
#  s.dependency 'ReactiveObjC'
#  s.ios.vendored_frameworks = 'HPTunerFunction/HPTunerFunction.framework'
  # s.dependency 'AFNetworking', '~> 2.3'
end
