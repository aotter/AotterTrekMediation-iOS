// swift-tools-version:5.9
// Release manifest of the AotterTrek mediation adapters (repo aotter/AotterTrekMediation-iOS).
// A binaryTarget cannot declare dependencies, so every product is an ObjC wrapper target that depends on the adapter
// binary, on AotterTrekSDK, and on the ad network's own Swift package. The wrapper source, Sources/<name>/LinkAnchor.m,
// references the classes the ad network looks up by name, so a static link keeps them without the integrator adding
// -ObjC. The wrappers have no headers, and SwiftPM refuses a C-family target whose default public header directory
// ("include") is missing, hence publicHeadersPath ".".
import PackageDescription

let package = Package(
    name: "AotterTrekMediation-iOS",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "AotterTrekAdMobMediation", targets: ["AotterTrekGoogleMobileAdsMediationWrapper"]),
        .library(name: "AotterTrekGAMMediation", targets: ["AotterTrekGoogleMobileAdsMediationWrapper"]),
        .library(name: "AotterTrekMAXMediation", targets: ["AotterTrekMAXMediationWrapper"]),
    ],
    dependencies: [
        .package(url: "https://github.com/aotter/AotterTrekSDK-iOS.git", from: "5.0.0"),
        // The ad-network ranges cover the majors this adapter supports; `from:` would pin a single major and lock a
        // Google Mobile Ads 13 app out of this package.
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads.git", "12.0.0" ..< "14.0.0"),
        .package(url: "https://github.com/AppLovin/AppLovin-MAX-Swift-Package.git", "13.0.0" ..< "14.0.0"),
    ],
    targets: [
        .binaryTarget(name: "AotterTrekGoogleMobileAdsMediation", path: "AotterTrekGoogleMobileAdsMediation.xcframework"),
        .binaryTarget(name: "AotterTrekMAXMediation", path: "AotterTrekMAXMediation.xcframework"),
        .target(
            name: "AotterTrekGoogleMobileAdsMediationWrapper",
            dependencies: [
                "AotterTrekGoogleMobileAdsMediation",
                .product(name: "AotterTrekSDK", package: "AotterTrekSDK-iOS"),
                .product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads"),
            ],
            path: "Sources/AotterTrekGoogleMobileAdsMediationWrapper",
            publicHeadersPath: "."),
        .target(
            name: "AotterTrekMAXMediationWrapper",
            dependencies: [
                "AotterTrekMAXMediation",
                .product(name: "AotterTrekSDK", package: "AotterTrekSDK-iOS"),
                .product(name: "AppLovinSDK", package: "AppLovin-MAX-Swift-Package"),
            ],
            path: "Sources/AotterTrekMAXMediationWrapper",
            publicHeadersPath: "."),
    ]
)
