//
//  AotterTrekGoogleMobileAdsMediation.h
//  AotterTrekGoogleMobileAdsMediation
//
//  Umbrella header of the AdMob / Google Ad Manager mediation adapter for AotterTrekSDK 5.x.
//  Console class names: `AotterTrekGADMediaAdapter` (GADMediationAdapter), `AotterTrekGADCustomEventNativeAd` and
//  `AotterTrekGADCustomEventBannerAd` (legacy custom events). The adapter is a static framework that links nothing itself:
//  the app links GoogleMobileAds and AotterTrekSDK. GMA finds these classes by name at runtime, so a static link has to
//  keep them: with CocoaPods the Google Mobile Ads pod's -ObjC does, with Swift Package Manager the package's link anchor
//  does, and an app that adds the xcframework by hand links with `-ObjC`.
//

#import <Foundation/Foundation.h>

#import "AotterTrekGADMediaAdapter.h"
#import "AotterTrekGADCustomEventNativeAd.h"
#import "AotterTrekGADCustomEventBannerAd.h"
#import "AotterTrekGADMediationExtras.h"

FOUNDATION_EXPORT double AotterTrekGoogleMobileAdsMediationVersionNumber;
FOUNDATION_EXPORT const unsigned char AotterTrekGoogleMobileAdsMediationVersionString[];
