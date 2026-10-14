//
//  AotterTrekGADCustomEventNativeAd.h
//  AotterTrekGoogleMobileAdsMediation
//
//  Legacy GADCustomEventNativeAd entry point (kept for consoles still configured with the 1.x class name).
//  Server parameter: {"clientId": "…", "adPlace": "…"}; request extras (GADCustomEventExtras) keys: category, contentTitle, contentUrl.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

NS_ASSUME_NONNULL_BEGIN

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@interface AotterTrekGADCustomEventNativeAd : NSObject <GADCustomEventNativeAd>
@end
#pragma clang diagnostic pop

NS_ASSUME_NONNULL_END
