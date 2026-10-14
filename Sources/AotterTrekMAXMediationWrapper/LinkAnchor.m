//
//  LinkAnchor.m
//  AotterTrekMAXMediationWrapper
//
//  AppLovin MAX finds the adapter class by name at runtime, so nothing in an app references it, and a static link
//  leaves out every archive member nobody references. Xcode links this source target as a whole object file, so the
//  reference below pulls the adapter in without the app adding -ObjC, which a Swift package cannot add for it.
//  CocoaPods does not use this file: the podspec's -ObjC covers that route.
//

@import AotterTrekMAXMediation;

__attribute__((used)) static void AotterTrekMAXMediationLinkAnchor(void) {
    (void)[AotterTrekMAXMediationAdapter class];
}
