//
//  AotterTrekMAXMediation.h
//  AotterTrekMAXMediation
//
//  Umbrella header of the AppLovin MAX custom-network adapter for AotterTrekSDK 5.x.
//  Console: iOS adapter class name `AotterTrekMAXMediationAdapter`, App ID = Trek client id, Placement ID = Trek place uid.
//  The adapter is a static framework that links nothing itself: the app links AppLovinSDK and AotterTrekSDK. MAX finds
//  the class by name at runtime, so a static link has to keep it: with CocoaPods this pod's MAX subspec adds -ObjC, with
//  Swift Package Manager the package's link anchor does, and an app that adds the xcframework by hand links with `-ObjC`.
//

#import <Foundation/Foundation.h>

#import "AotterTrekMAXMediationAdapter.h"

FOUNDATION_EXPORT double AotterTrekMAXMediationVersionNumber;
FOUNDATION_EXPORT const unsigned char AotterTrekMAXMediationVersionString[];
