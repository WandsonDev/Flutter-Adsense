import 'dart:js_interop';

import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;

// ---------------------------------------------------------------------------
// JS interop helper — replaces html.window.eval()
// ---------------------------------------------------------------------------

/// Calls the browser's global [eval] function.
/// Used to trigger `(adsbygoogle = window.adsbygoogle || []).push({})`.
@JS('eval')
external JSAny? _jsEval(String expression);

// ---------------------------------------------------------------------------
// FlutterAdsense — Singleton core service
// ---------------------------------------------------------------------------

/// Manages the Google AdSense script lifecycle for Flutter Web.
///
/// Call [initialize] once, before [runApp], with your Publisher ID:
/// ```dart
/// void main() {
///   FlutterAdsense().initialize('ca-pub-XXXXXXXXXXXXXXXX');
///   runApp(const MyApp());
/// }
/// ```
class FlutterAdsense {
  static final FlutterAdsense _instance = FlutterAdsense._internal();

  factory FlutterAdsense() => _instance;
  FlutterAdsense._internal();

  bool _isInitialized = false;

  /// Whether the AdSense script has been injected into `<head>`.
  bool get isInitialized => _isInitialized;

  /// Injects `adsbygoogle.js` into `<head>` exactly once.
  ///
  /// [clientId] must be your Google AdSense Publisher ID,
  /// e.g. `'ca-pub-XXXXXXXXXXXXXXXX'`.
  ///
  /// Calling this more than once is safe and has no effect.
  /// On non-web platforms the call is silently ignored.
  void initialize(String clientId) {
    if (!kIsWeb) {
      debugPrint('[FlutterAdsense] Only supported on Flutter Web.');
      return;
    }

    if (_isInitialized) {
      debugPrint('[FlutterAdsense] Already initialized — skipping.');
      return;
    }

    assert(
      clientId.startsWith('ca-pub-'),
      '[FlutterAdsense] clientId must start with "ca-pub-". Got: $clientId',
    );

    try {
      final script = web.HTMLScriptElement()
        ..async = true
        ..src =
            'https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=$clientId'
        ..crossOrigin = 'anonymous';

      web.document.head?.append(script);
      _isInitialized = true;

      debugPrint('[FlutterAdsense] Initialized (client: $clientId).');
    } catch (e) {
      debugPrint('[FlutterAdsense] Failed to initialize: $e');
    }
  }

  /// Calls `(adsbygoogle = window.adsbygoogle || []).push({})` to ask the
  /// AdSense SDK to fill the nearest unfilled `<ins>` slot.
  ///
  /// This is called automatically by [AdsenseWidget] after the `<ins>`
  /// element is attached to the DOM. You rarely need to call it manually.
  void pushAd() {
    if (!kIsWeb) return;

    if (!_isInitialized) {
      debugPrint(
        '[FlutterAdsense] pushAd() called before initialize(). '
        'Make sure to call FlutterAdsense().initialize() in main().',
      );
      return;
    }

    try {
      _jsEval('(adsbygoogle = window.adsbygoogle || []).push({})');
    } catch (e) {
      debugPrint('[FlutterAdsense] pushAd() error: $e');
    }
  }
}
