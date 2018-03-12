#
# Be sure to run `pod lib lint InstaNetworking.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'InstaNetworking'
  s.version          = '0.1.0'
  s.summary          = 'InstaNetworking is a networking framework for easy http(s) requests'
  s.description      = 'InstaNetworking is a networking framework for easy http(s) requests.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
InstaNetworking is a networking framework for easy http(s) requests.
                       DESC

  s.homepage         = 'https://github.com/mahmoud-amer-m/Instabug'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mahmoud.amer.m@gmail.com' => 'mahmoud.amer.m@gmail.com' }
  s.source           = { :git => 'https://github.com/mahmoud-amer-m/Instabug', :tag => '0.1.0' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'InstaNetworking/Classes/**/*'
  
  # s.resource_bundles = {
  #   'InstaNetworking' => ['InstaNetworking/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
