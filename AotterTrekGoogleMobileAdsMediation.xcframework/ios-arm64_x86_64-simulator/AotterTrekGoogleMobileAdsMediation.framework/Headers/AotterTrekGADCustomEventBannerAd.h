//
//  AotterTrekGADCustomEventBannerAd.h
//  AotterTrekGoogleMobileAdsMediation
//
//  Legacy GADCustomEventBanner entry point (kept for consoles still configured with the 1.x class name).
//  Server parameter: {"clientId": "…", "adPlace": "…"}; request extras (GADCustomEventExtras) keys: category, contentTitle, contentUrl.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

NS_ASSUME_NONNULL_BEGIN

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@interface AotterTrekGADCustomEventBannerAd : NSObject <GADCustomEventBanner>
@end
#pragma clang diagnostic pop

NS_ASSUME_NONNULL_END
