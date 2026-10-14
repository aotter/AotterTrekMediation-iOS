//
//  LinkAnchor.m
//  AotterTrekGoogleMobileAdsMediationWrapper
//
//  Google Mobile Ads finds the adapter classes by name at runtime, so nothing in an app references them, and a static
//  link leaves out every archive member nobody references. Xcode links this source target as a whole object file, so
//  the references below pull the adapter in without the app adding -ObjC, which a Swift package cannot add for it.
//  CocoaPods does not use this file: there the Google Mobile Ads pod's -ObjC keeps these classes.
//

@import AotterTrekGoogleMobileAdsMediation;

__attribute__((used)) static void AotterTrekGoogleMobileAdsMediationLinkAnchor(void) {
    (void)[AotterTrekGADMediaAdapter class];
    (void)[AotterTrekGADCustomEventNativeAd class];
    (void)[AotterTrekGADCustomEventBannerAd class];
}
