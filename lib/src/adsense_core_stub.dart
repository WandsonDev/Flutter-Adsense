// ignore_for_file: avoid_web_libraries_in_flutter

/// No-op stub used on non-web platforms (mobile, desktop).
/// All public members are present so the API surface is identical,
/// but nothing is executed at runtime.
class FlutterAdsense {
  static final FlutterAdsense _instance = FlutterAdsense._internal();
  factory FlutterAdsense() => _instance;
  FlutterAdsense._internal();

  /// Always [false] on non-web platforms.
  bool get isInitialized => false;

  /// No-op on non-web platforms.
  // ignore: avoid_unused_parameters
  void initialize(String clientId) {}

  /// No-op on non-web platforms.
  void pushAd() {}
}
