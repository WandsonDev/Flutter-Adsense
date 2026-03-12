import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_adsense/flutter_adsense.dart';

void main() {
  group('FlutterAdsense', () {
    test('is a singleton', () {
      final a = FlutterAdsense();
      final b = FlutterAdsense();
      expect(identical(a, b), isTrue);
    });

    test('isInitialized starts false', () {
      expect(FlutterAdsense().isInitialized, isFalse);
    });

    test('initialize() is safe to call on non-web (no crash)', () {
      // On a test environment (non-web), initialize() should silently no-op.
      expect(
        () => FlutterAdsense().initialize('ca-pub-0000000000000000'),
        returnsNormally,
      );
    });

    test('pushAd() is safe to call on non-web (no crash)', () {
      expect(() => FlutterAdsense().pushAd(), returnsNormally);
    });
  });

  group('AdsenseWidget', () {
    testWidgets('renders SizedBox.shrink on non-web', (tester) async {
      await tester.pumpWidget(
        const AdsenseWidget(
          adClient: 'ca-pub-0000000000000000',
          adSlot: '1234567890',
          width: 320,
          height: 100,
        ),
      );

      // On non-web the stub renders SizedBox.shrink — zero size.
      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
      // SizedBox.shrink has no explicit width/height (they are null, not 0).
      expect(sizedBox.width, isNull);
      expect(sizedBox.height, isNull);
    });
  });
}
