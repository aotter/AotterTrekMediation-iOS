# Changelog

## 5.0.0 (100)

First release of the AotterTrek mediation adapters as a separate product, rewritten on the SDK's public `ATK` API.

### Added
- `AotterTrekGoogleMobileAdsMediation`: `AotterTrekGADMediaAdapter` (the modern `GADMediationAdapter` entry point for
  AdMob and Google Ad Manager, native and banner), the legacy custom-event classes
  `AotterTrekGADCustomEventNativeAd` and `AotterTrekGADCustomEventBannerAd`, and `AotterTrekGADMediationExtras` for
  per-request category, content URL and content title.
- `AotterTrekMAXMediation`: `AotterTrekMAXMediationAdapter`, serving AppLovin MAX native, banner and MREC placements.
- Subspecs `GoogleMobileAds` (default), `AdMob`, `GAM` and `MAX`; Swift Package Manager products
  `AotterTrekAdMobMediation`, `AotterTrekGAMMediation` and `AotterTrekMAXMediation`.
- A privacy manifest inside each adapter framework.
- Neither route needs `-ObjC` from the integrator: CocoaPods adds it (through the Google Mobile Ads pod, and through
  this pod's MAX subspec), and each Swift package product references its adapter classes so a static link keeps them.
- A console warning when an adapter releases a loaded native ad that the ad network never rendered, the sign of a
  media view placed on screen without the network's own ad view.

### Changed
- Configuration errors no longer look like no-fill. A client id that disagrees with the one the app initialised, an
  unsupported ad type, a missing placement and an uninitialised SDK map to `GADErrorInvalidRequest` on Google Mobile
  Ads and to `MAAdapterError.invalidConfiguration` on MAX; only the ad server's answer that it has no ad maps to no-fill.
- The adapters ship as static frameworks and embed neither the ad network SDKs nor AotterTrekSDK.
- `extraAssets` keys follow the Android adapter's names (`MainImage`, `IconImage`, `IconImageHd`, `Sponsor`);
  `adPlace` and the size keys are unchanged. The mapping from the 1.x names is in the README.

### Known limitations
- The AppLovin MAX adapter is provided as is, without technical support.
