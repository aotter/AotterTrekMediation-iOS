//
//  AotterTrekGADMediationExtras.h
//  AotterTrekGoogleMobileAdsMediation
//
//  Publisher-side request extras for the modern adapter path: `[request registerAdNetworkExtras:extras]`.
//  Same three values the Android adapter reads from its mediation extras (Category / ContentUrl / ContentTitle).
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

NS_ASSUME_NONNULL_BEGIN

@interface AotterTrekGADMediationExtras : NSObject <GADAdNetworkExtras>
@property (nonatomic, copy, nullable) NSString *category;
@property (nonatomic, copy, nullable) NSString *contentURL;
@property (nonatomic, copy, nullable) NSString *contentTitle;
@end

NS_ASSUME_NONNULL_END
