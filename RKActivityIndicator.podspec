#
# Be sure to run `pod lib lint RKActivityIndicator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RKActivityIndicator'
  s.version          = '1.0.0'
  s.summary          = 'A custom Activity Indicator.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
RKActivityIndicator is a custom activity indicator build using swift, which you can use in your projects based on your need. It comes mainly in two variants, definite and indefinite progress. You can customize it by providing your own image set for animation.
                       DESC

  s.homepage         = 'https://github.com/radhakrishnapai/RKActivityIndicator'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Radhakrishna Pai' => 'radhakrishnapai09@gmail.com' }
  s.source           = { :git => 'https://github.com/radhakrishnapai/RKActivityIndicator.git', :tag => 'v'+s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'RKActivityIndicator/Classes/**/*'
  
  # s.resource_bundles = {
  #   'RKActivityIndicator' => ['RKActivityIndicator/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
