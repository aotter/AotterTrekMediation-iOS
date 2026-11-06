# Changelog

## 5.0.1 (101)

### Added
- `extraAssets["adType"]` on Google Mobile Ads native ads: the placement type the ad was served for, "NATIVE",
  "NATIVE_MULTIMEDIA" or "BANNER".
- Native Multimedia Ads shown through the adapters, in native ads and in banners, move with the page when the app calls
  `+[AotterTrekSDK notifyAdScrolled]` from `scrollViewDidScroll` (new in AotterTrekSDK 5.0.1).

### Changed
- This release requires AotterTrekSDK 5.0.1 or later and does not work with 5.0.0. The pod and the Swift package
  declare the minimum.

### Fixed
- Google Mobile Ads now counts the clicks on an interactive Native Multimedia Ad, clicks in its pop-up included, in a
  native ad or a banner.

### Missing from the 5.0.0 notes (upgrading from 1.x)
- Banners: 5.0 lays a banner out at the size the request asks for, and a request without a height gets the placement's
  size. 1.x did not follow the requested size.
- Scrolling: 5.0 no longer receives the `"SuprAdScrolled"` notification the 1.x adapters listened for. With 5.0.1,
  call `+[AotterTrekSDK notifyAdScrolled]` instead; it moves the ads in banners too.

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
