# flutter_adsense

[![pub version](https://img.shields.io/pub/v/flutter_adsense.svg)](https://pub.dev/packages/flutter_adsense)
[![Flutter Web](https://img.shields.io/badge/platform-Flutter%20Web-blue.svg)](https://flutter.dev/web)
[![Wasm compatible](https://img.shields.io/badge/Wasm-compatible-green.svg)](https://docs.flutter.dev/platform-integration/web/wasm)

Flutter Web library to initialize, manage, and display **Google AdSense** ads.

Built with `package:web` + `dart:js_interop` — fully compatible with both
the JavaScript and **WebAssembly** compilation targets.

---

## Features

| | |
|---|---|
| 🚀 **Zero dart:html** | Uses `package:web` + `dart:js_interop` — Wasm-ready. |
| 🧩 **Single widget** | Drop `AdsenseWidget` anywhere in your layout. |
| 🛡️ **Safe on all platforms** | Conditional exports provide no-op stubs on mobile/desktop. |
| ⏱️ **Correct push timing** | Uses `addPostFrameCallback` to push the ad only after the `<ins>` element is live in the DOM. |
| 🔒 **Singleton core** | `FlutterAdsense` injects the script only once, regardless of how many times `initialize()` is called. |

---

## Installation

```yaml
dependencies:
  flutter_adsense: ^1.0.0
```

```bash
flutter pub get
```

---

## Setup

### 1. Add the AdSense `auto-ads` snippet to `web/index.html` *(optional but recommended)*

If you use AdSense Auto Ads, add the script tag to your `web/index.html` inside `<head>`.
Alternatively, skip this step and use only the `AdsenseWidget` for manual placement.

```html
<!-- web/index.html — inside <head> -->
<script async
  src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-XXXXXXXXXXXXXXXX"
  crossorigin="anonymous">
</script>
```

### 2. Initialize in `main.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_adsense/flutter_adsense.dart';

void main() {
  // Injects adsbygoogle.js into <head> exactly once.
  FlutterAdsense().initialize('ca-pub-XXXXXXXXXXXXXXXX');

  runApp(const MyApp());
}
```

### 3. Display ad units

```dart
import 'package:flutter/material.dart';
import 'package:flutter_adsense/flutter_adsense.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Your content…
          const Text('Hello World'),

          // Leaderboard banner
          const AdsenseWidget(
            adClient: 'ca-pub-XXXXXXXXXXXXXXXX',
            adSlot: '1234567890',
            width: 728,
            height: 90,
          ),
        ],
      ),
    );
  }
}
```

---

## AdsenseWidget parameters

| Parameter | Type | Default | Description |
|---|---|---|---|
| `adClient` | `String` | required | Your AdSense Publisher ID (`ca-pub-…`) |
| `adSlot` | `String` | required | The ad block / slot ID |
| `adFormat` | `String` | `'auto'` | AdSense format: `'auto'`, `'rectangle'`, `'vertical'`, `'horizontal'` |
| `fullWidthResponsive` | `bool` | `true` | Allow the ad to stretch to container width |
| `width` | `double` | required | Width in logical pixels |
| `height` | `double` | required | Height in logical pixels |

---

## Common ad sizes

| Name | Width | Height |
|---|---|---|
| Leaderboard | 728 | 90 |
| Medium Rectangle | 300 | 250 |
| Large Rectangle | 336 | 280 |
| Half Page | 300 | 600 |
| Mobile Banner | 320 | 50 |

---

## Notes

* This package targets **Flutter Web only**. On mobile/desktop it compiles
  safely via no-op stubs, but ads will not be shown.
* AdSense policies require your site to be approved before ads serve.
* During development you will see an empty white space where the ad would
  appear — this is expected.

---

## Author

Developed by **Wandson Dev**.
