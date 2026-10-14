//
//  AotterTrekGADMediaAdapter.h
//  AotterTrekGoogleMobileAdsMediation
//
//  The GADMediationAdapter entry point (AdMob and Google Ad Manager, native and banner). Enter this class name in the
//  console's custom event and put {"clientId": "<Trek client id>", "adPlace": "<place uid>"} in its parameter field.
//  GMA creates one instance per ad request.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

NS_ASSUME_NONNULL_BEGIN

@interface AotterTrekGADMediaAdapter : NSObject <GADMediationAdapter>
@end

NS_ASSUME_NONNULL_END
