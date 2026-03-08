// Using the standard Flutter URL launcher instead of custom JS implementation
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

void launchUrl(String url, {bool newTab = true}) async {
  String finalUrl = url;

  if (kIsWeb) {
    // In Flutter Web, assets are located at assets/assets/...
    if (url.startsWith('assets/')) {
      finalUrl = 'assets/$url';
    }
    
    final Uri uri = Uri.parse(finalUrl);
    
    // canLaunchUrl often returns false for local web assets, 
    // but launchUrl still works. We'll skip the check for relative paths on web.
    if (finalUrl.startsWith('http') || finalUrl.startsWith('mailto') || finalUrl.startsWith('tel')) {
      if (await url_launcher.canLaunchUrl(uri)) {
        await url_launcher.launchUrl(
          uri,
          webOnlyWindowName: newTab ? '_blank' : '_self',
        );
      }
    } else {
      // Internal path (asset)
      await url_launcher.launchUrl(
        uri,
        webOnlyWindowName: newTab ? '_blank' : '_self',
      );
    }
  } else {
    // Mobile/other platforms
    final Uri uri = Uri.parse(url);
    if (await url_launcher.canLaunchUrl(uri)) {
      await url_launcher.launchUrl(uri);
    }
  }
}
