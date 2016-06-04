#
# Be sure to run `pod lib lint BatSignal.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BatSignal'
  s.version          = '0.1.0'
  s.summary          = 'BatSignal is a low frequency audio comminication framework written in swift.'

  s.description      = <<-DESC
Stuck trying to sync data without any internet connection? Bluetooth is not good enough for your project? Or it's a pain to share between Android and iOS?
BatSignal makes use of low frequency audio tokens in order to quickly share data between different device using speakers and microphone.
Stay close, within 5 meters far from the other device, and that's all. All the magic is provided by this framework'
                       DESC

  s.homepage         = 'https://github.com/<matteocrippa>/BatSignal'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Matteo Crippa' => "@ghego20" }
  s.source           = { :git => 'https://github.com/<matteocrippa>/BatSignal.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/@ghego20'

  s.ios.deployment_target = '9.0'

  s.source_files = 'BatSignal/Classes/**/*'
  
  s.dependency 'AudioKit', '~> 3.1'
  s.dependency 'Chronos-Swift'
end
