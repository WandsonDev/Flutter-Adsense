import 'package:flutter/material.dart';
import 'package:flutter_adsense/flutter_adsense.dart';

void main() {
  // Initialize AdSense ONCE before runApp.
  // Replace with your real Publisher ID.
  FlutterAdsense().initialize('ca-pub-0000000000000000');

  runApp(const AdsenseExampleApp());
}

class AdsenseExampleApp extends StatelessWidget {
  const AdsenseExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter AdSense Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4285F4),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          elevation: 0,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter AdSense — Example'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ----- App content -----
            const Text(
              'Your App Content',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2C),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: const Text('Article, feed, or dashboard content here…'),
            ),

            const SizedBox(height: 40),

            // ----- Leaderboard banner (728×90) -----
            const Text(
              'Sponsored',
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
            const SizedBox(height: 6),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white12),
              ),
              child: const AdsenseWidget(
                adClient: 'ca-pub-0000000000000000',
                adSlot: '9876543210',
                adFormat: 'auto',
                fullWidthResponsive: true,
                width: 728,
                height: 90,
              ),
            ),

            const SizedBox(height: 40),

            // ----- Medium rectangle (300×250) -----
            const Text(
              'Sponsored',
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
            const SizedBox(height: 6),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white12),
              ),
              child: const AdsenseWidget(
                adClient: 'ca-pub-0000000000000000',
                adSlot: '1234567890',
                adFormat: 'rectangle',
                fullWidthResponsive: false,
                width: 300,
                height: 250,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
