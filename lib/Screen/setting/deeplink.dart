import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class MyHomePage extends StatelessWidget {
  final String videoURL = "https://media.w3.org/2010/05/sintel/trailer.mp4";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Web Video Caster Integration'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _launchWebVideoCaster();
          },
          child: Text('Open Web Video Caster'),
        ),
      ),
    );
  }

  void _launchWebVideoCaster() async {
    final String secureUriParam = "secure_uri=true";
    final String encodedSecureUriParam = Uri.decodeComponent(secureUriParam);
    final String webVideoCasterURL =
        'wvc-x-callback://open?url=${Uri.decodeComponent(videoURL)}&${encodedSecureUriParam}';

    try {
      // Try to launch Web Video Caster using the custom URL scheme
      await launch(webVideoCasterURL);
    } catch (e) {
      // Handle the exception (e.g., the app is not installed)
      // Open Play Store if it fails to launch the app because the package doesn't exist.
      // Alternatively, you could use PackageManager.getLaunchIntentForPackage() and check for null.
      // You could try catch this and launch the Play Store website if it fails,
      // but this shouldn’t fail unless the Play Store is missing.
      final String playStoreURL =
          'market://details?id=com.instantbits.cast.webvideo';
      await launch(playStoreURL);
    }
  }
}