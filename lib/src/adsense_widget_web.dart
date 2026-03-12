import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:web/web.dart' as web;

import 'adsense_core_web.dart';

/// A Flutter widget that renders a Google AdSense `<ins>` ad block.
///
/// Add this widget anywhere inside your Flutter Web layout:
/// ```dart
/// AdsenseWidget(
///   adClient: 'ca-pub-XXXXXXXXXXXXXXXX',
///   adSlot: '1234567890',
///   width: 728,
///   height: 90,
/// )
/// ```
///
/// > **Important:** [FlutterAdsense.initialize] must be called in `main()`
/// > before [runApp]. Without it the widget renders an empty space.
class AdsenseWidget extends StatelessWidget {
  /// Your Google AdSense Publisher ID, e.g. `'ca-pub-XXXXXXXXXXXXXXXX'`.
  final String adClient;

  /// The ad slot / block ID from your AdSense dashboard.
  final String adSlot;

  /// Ad format as defined by AdSense, defaults to `'auto'`.
  /// Other common values: `'rectangle'`, `'vertical'`, `'horizontal'`.
  final String adFormat;

  /// Whether to allow AdSense to stretch the ad to the full container width.
  final bool fullWidthResponsive;

  /// Desired width in logical pixels.
  final double width;

  /// Desired height in logical pixels.
  final double height;

  const AdsenseWidget({
    super.key,
    required this.adClient,
    required this.adSlot,
    this.adFormat = 'auto',
    this.fullWidthResponsive = true,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      // HtmlElementView.fromTagName is the modern Flutter Web API
      // (replaces the manual platformViewRegistry.registerViewFactory pattern).
      // onElementCreated fires before the element is attached to the DOM,
      // so the actual AdSense push is scheduled via addPostFrameCallback,
      // which fires after the frame is fully rendered and the element is live.
      child: HtmlElementView.fromTagName(
        tagName: 'ins',
        onElementCreated: (Object element) {
          final ins = element as web.HTMLElement;

          ins.className = 'adsbygoogle';
          ins.style.display = 'block';
          ins.style.width = '${width}px';
          ins.style.height = '${height}px';

          // Use setAttribute so these map to the data-* attributes AdSense reads.
          ins.setAttribute('data-ad-client', adClient);
          ins.setAttribute('data-ad-slot', adSlot);
          ins.setAttribute('data-ad-format', adFormat);
          ins.setAttribute(
              'data-full-width-responsive', fullWidthResponsive.toString());

          // Wait until the Flutter frame is fully rendered (element in DOM)
          // before calling push({}). This is more reliable than microtask.
          SchedulerBinding.instance.addPostFrameCallback((_) {
            FlutterAdsense().pushAd();
          });
        },
      ),
    );
  }
}
