# Release podspec of the AotterTrek mediation adapters (repo aotter/AotterTrekMediation-iOS).
Pod::Spec.new do |s|
  s.name                  = 'AotterTrekMediation'
  s.version               = '5.0.0'
  s.summary               = 'AotterTrek mediation adapters for Google Mobile Ads (AdMob / Ad Manager) and AppLovin MAX.'
  s.description           = <<-DESC
    Closed-source mediation adapters that let Google Mobile Ads (AdMob and Google Ad Manager) and AppLovin MAX serve
    AotterTrek native and banner ads through AotterTrekSDK 5.0.0 or later. Pure Objective-C static frameworks; the app links the
    ad network SDKs and AotterTrekSDK itself. Subspecs: GoogleMobileAds (default; AdMob and GAM are aliases), MAX.
  DESC
  s.homepage              = 'https://github.com/aotter/AotterTrekMediation-iOS'
  s.license               = { :type => 'Commercial', :file => 'LICENSE' }
  s.authors               = { 'Aotter' => 'sdk@aotter.net' }
  s.source                = { :git => 'https://github.com/aotter/AotterTrekMediation-iOS.git', :tag => s.version.to_s }
  s.ios.deployment_target = '15.0'
  s.static_framework      = true
  s.dependency 'AotterTrekSDK', '>= 5.0.0'   # inherited by every subspec: installing only MAX still brings the SDK
  s.default_subspecs      = 'GoogleMobileAds'

  s.subspec 'GoogleMobileAds' do |ss|
    ss.vendored_frameworks = 'AotterTrekGoogleMobileAdsMediation.xcframework'
    ss.dependency 'Google-Mobile-Ads-SDK', '>= 12.0', '< 14.0'
  end
  s.subspec 'AdMob' do |ss|
    ss.dependency 'AotterTrekMediation/GoogleMobileAds'
  end
  s.subspec 'GAM' do |ss|
    ss.dependency 'AotterTrekMediation/GoogleMobileAds'
  end
  s.subspec 'MAX' do |ss|
    ss.vendored_frameworks = 'AotterTrekMAXMediation.xcframework'
    # MAX finds this adapter by class name, and nothing in the app references it, so without -ObjC the linker drops it
    # and the network simply never fills, with no error to chase. The Google pod declares the same flag for its own
    # consumers; AppLovin's declares it only for its own target, so a MAX-only install would get nothing.
    ss.user_target_xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }
    ss.dependency 'AppLovinSDK', '>= 13.0', '< 14.0'
  end
end
