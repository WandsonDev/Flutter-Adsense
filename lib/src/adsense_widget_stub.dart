import 'package:flutter/widgets.dart';

/// No-op stub used on non-web platforms.
/// Renders an invisible [SizedBox] so that widget trees compile on all targets.
class AdsenseWidget extends StatelessWidget {
  // ignore: avoid_unused_parameters
  const AdsenseWidget({
    super.key,
    required String adClient,
    required String adSlot,
    String adFormat = 'auto',
    bool fullWidthResponsive = true,
    double width = 320,
    double height = 100,
  });

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
