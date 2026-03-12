/// Flutter AdSense — Google AdSense for Flutter Web.
///
/// Import this library in your Flutter Web project:
/// ```dart
/// import 'package:flutter_adsense/flutter_adsense.dart';
/// ```
///
/// On non-web platforms the classes resolve to no-op stubs,
/// so the package compiles safely on all targets.
library flutter_adsense;

// Core (Singleton that injects the AdSense script into <head>)
export 'src/adsense_core_stub.dart'
    if (dart.library.js_interop) 'src/adsense_core_web.dart';

// Widget (renders the <ins> ad block inside Flutter)
export 'src/adsense_widget_stub.dart'
    if (dart.library.js_interop) 'src/adsense_widget_web.dart';
