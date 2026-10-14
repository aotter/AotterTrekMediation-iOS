# AotterTrek mediation adapters for iOS

Lets Google Mobile Ads (AdMob and Google Ad Manager) and AppLovin MAX serve AotterTrek native and banner ads. Both
adapters are pure Objective-C static frameworks built on the public API of
[AotterTrekSDK](https://github.com/aotter/AotterTrekSDK-iOS) 5.0.0 or later; they embed neither the ad network
SDKs nor the AotterTrek SDK, so your app keeps deciding those versions.

- **Requirements**: iOS 15 or later, AotterTrekSDK 5.0.0 or later (same major version with SPM), and Google Mobile Ads 12.x or 13.x, or AppLovin SDK 13.x.

## Install

> **Upgrading from 1.x?** Remove `pod 'TrekSDKAdMobMediationObjc'` first. This pod defines the same adapter classes by
> the same names, and `-ObjC` pulls both copies into the binary: which one the runtime picks is not something you can
> control, and the old one links against a framework that no longer exists.

### CocoaPods

```ruby
pod 'AotterTrekMediation'                      # Google Mobile Ads adapter (default subspec)
pod 'AotterTrekMediation/MAX'                  # AppLovin MAX adapter
pod 'AotterTrekMediation/AdMob'                # alias of the Google Mobile Ads subspec
pod 'AotterTrekMediation/GAM'                  # same adapter, named for Google Ad Manager
```

Every subspec brings AotterTrekSDK with it.

### Swift Package Manager

Add `https://github.com/aotter/AotterTrekMediation-iOS` and pick a product: `AotterTrekAdMobMediation`,
`AotterTrekGAMMediation` (the same adapter) or `AotterTrekMAXMediation`.

### No linker flag to add

The ad networks find these adapters **by class name at runtime**, so nothing in your app references them, and a static
link leaves out what nobody references. Neither route needs you to add `-ObjC` for that. With CocoaPods it reaches your
app target on its own: the Google Mobile Ads pod adds it, and so does this pod's MAX subspec. Each Swift package
product references its adapter classes, so the linker keeps them. Adding `-ObjC` yourself does no harm. If the adapter never appears in the mediation report, check first that the product or subspec
for that network is linked into the app target.

## Google Mobile Ads (AdMob and Ad Manager)

In the AdMob or Ad Manager console, add a custom event to the ad unit's mediation group:

| Field | Value |
|---|---|
| Class Name | `AotterTrekGADMediaAdapter` |
| Parameter | `{"clientId": "<your Trek client id>", "adPlace": "<place uid>"}` |

The parameter also accepts `placeUid` as a synonym for `adPlace`. An `adType` key from a 1.x setup is ignored: 5.0
decides how to render from the response itself, so one custom event serves both native and SuprAd places.

The earlier class names `AotterTrekGADCustomEventNativeAd` and `AotterTrekGADCustomEventBannerAd` still work, so an
existing 1.x console setup keeps serving without being touched.

Show a native ad through a `GADNativeAdView`: put the `GADMediaView` inside it, set it as the view's `mediaView`, and set
the view's `nativeAd` after its asset views are assigned. Google Mobile Ads tells the adapter that an ad is on screen
only when it is registered this way. A `GADMediaView` added to the screen by itself stays blank, and no impression or
click is reported. The adapter logs a warning when it releases an ad that was never rendered.

Per-request values are optional. `AotterTrekGADMediationExtras` reaches only `AotterTrekGADMediaAdapter`; the earlier
class names keep reading `category`, `contentUrl` and `contentTitle` from `GADCustomEventExtras` (`CustomEventExtras`
in Swift): set them with `setExtras(_:forLabel:)` under the custom event's label in the console, then register them
on the request. Match the extras to the class your console names:

```swift
let extras = AotterTrekGADMediationExtras()
extras.category = "news"
extras.contentURL = "https://example.com/article/1"
extras.contentTitle = "…"
let request = Request()
request.register(extras)
```

### What `extraAssets` carries

Beyond the standard native assets, the adapter puts these keys in `GADNativeAd.extraAssets`. 5.0 provides exactly
these. The 1.x adapter used different names, so a host that read them has to move:

| 1.x key | 5.0 key |
|---|---|
| `trekAd` (`nativeAd` / `suprAd`) | none -- decide the layout by ad unit: one ad unit serves one placement type |
| `adPlace` | `adPlace` |
| `adSizeWidth` / `adSizeHeight` | `adSizeWidth` / `adSizeHeight` (`NSNumber`; only when the creative reports a size) |
| `img_icon` | `IconImage` |
| `img_icon_hd` | `IconImageHd` |
| `img_main` | `MainImage` |
| -- | `Sponsor` |

The image URLs are also available as the standard `images` and `icon`, which is the preferred way to read them.

## AppLovin MAX

> The MAX adapter is provided as is, without technical support.

In the MAX dashboard, add AotterTrek as a custom network:

| Field | Value |
|---|---|
| iOS Adapter Class Name | `AotterTrekMAXMediationAdapter` |
| App ID | your Trek client id |
| Placement ID (per ad unit) | the place uid |

Native, banner and MREC are supported; leader and the fullscreen formats are not, and a request for them fails with a
configuration error rather than an empty fill. Per-request values go through local extra parameters:

```swift
loader.setLocalExtraParameter(forKey: AotterTrekMAXCategoryKey, value: "news")
loader.setLocalExtraParameter(forKey: AotterTrekMAXContentURLKey, value: "https://example.com/article/1")
loader.setLocalExtraParameter(forKey: AotterTrekMAXContentTitleKey, value: "…")
```

The same keys work on `MAAdView` and `MANativeAdLoader`; in Objective-C the selector is
`setLocalExtraParameterForKey:value:`.

Render a native ad through `MANativeAdLoader`, with a template or with `renderNativeAdView:withAd:`. MAX tells the
adapter that an ad is on screen only then. Views placed by hand stay blank, and no impression or click is reported. The
adapter logs a warning when it releases an ad that was never rendered.

## How errors surface

A configuration mistake looks different from a request the ad server has no ad for, so the mediation report tells
you which one you have:

| What happened | Google Mobile Ads | AppLovin MAX |
|---|---|---|
| No ad for this request (a paused or archived placement included) | `GADErrorNoFill` | `MAAdapterError.noFill` |
| Client id disagrees with the one the app initialised, unsupported ad type, missing place, SDK not initialised | `GADErrorInvalidRequest` | `MAAdapterError.invalidConfiguration` |
| Anything else | `GADErrorInternalError` | `MAAdapterError.unspecified` |

The adapter never overrides an identity the app already established: if your app initialises AotterTrekSDK with one
client id and the console carries another, the request fails instead of silently switching accounts. An app that also
uses MyApp initialises the SDK itself, with
`[[AotterTrek sharedAPI] initTrekServiceWithClientId:secret:myAppClientId:myAppClientSecret:]`, before starting the ad
network or loading the first ad: the adapter's own initialisation would clear the MyApp client id.

## Support

sdk@aotter.net
