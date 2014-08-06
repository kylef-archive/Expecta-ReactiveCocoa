Pod::Spec.new do |spec|
  spec.name = 'Expecta+ReactiveCocoa'
  spec.version = '0.2.0'
  spec.summary = 'Expecta matchers for ReactiveCocoa.'
  spec.homepage = 'https://github.com/kylef/Expecta-ReactiveCocoa'
  spec.license = { :type => 'BSD', :file => 'LICENSE' }
  spec.author = { 'Kyle Fuller' => 'inbox@kylefuller.co.uk' }
  spec.social_media_url = 'https://twitter.com/kylefuller'
  spec.source = { :git => 'https://github.com/kylef/Expecta-ReactiveCocoa.git', :tag => spec.version }
  spec.source_files  = 'ExpectaReactiveCocoa/*.{h,m}'
  spec.requires_arc = true
  spec.dependency 'Expecta'
  spec.dependency 'ReactiveCocoa'

  spec.ios.deployment_target = '5.0'
  spec.osx.deployment_target = '10.7'
end

