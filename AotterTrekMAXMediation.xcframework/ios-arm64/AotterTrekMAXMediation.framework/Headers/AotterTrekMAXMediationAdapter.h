//
//  AotterTrekMAXMediationAdapter.h
//  AotterTrekMAXMediation
//
//  MAX custom network adapter: native (image, HTML5, video — whatever the place serves) and banner / MREC ad views.
//  Per-request values go through `localExtraParameters` under the keys below (same names as the Android adapter).
//

#import <Foundation/Foundation.h>
#import <AppLovinSDK/AppLovinSDK.h>

NS_ASSUME_NONNULL_BEGIN

/// localExtraParameters keys: `[loader setLocalExtraParameterForKey:AotterTrekMAXCategoryKey value:@"news"]`.
FOUNDATION_EXPORT NSString *const AotterTrekMAXCategoryKey;       // "Category"
FOUNDATION_EXPORT NSString *const AotterTrekMAXContentURLKey;     // "ContentUrl"
FOUNDATION_EXPORT NSString *const AotterTrekMAXContentTitleKey;   // "ContentTitle"

@interface AotterTrekMAXMediationAdapter : ALMediationAdapter <MANativeAdAdapter, MAAdViewAdapter>
@end

NS_ASSUME_NONNULL_END
