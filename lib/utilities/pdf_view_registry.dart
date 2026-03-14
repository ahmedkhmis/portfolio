import 'dart:ui_web' as ui_web;
import 'package:web/web.dart' as web;
import 'package:app/utilities/app_constants.dart';

/// Registers iframe-based platform views for each resume PDF
/// so they can be embedded via [HtmlElementView] in Flutter web.
void registerResumePlatformViews() {
  final resumePaths = [
    AppConstants.resumeEnFull,
    AppConstants.resumeEnOne,
    AppConstants.resumeFrFull,
    AppConstants.resumeFrOne,
  ];

  for (final path in resumePaths) {
    // Flutter web serves assets at assets/<original-path>
    String webUrl = path;
    if (path.startsWith('assets/')) {
      webUrl = 'assets/$path';
    }

    final viewType = 'iframeElement-$webUrl';

    ui_web.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
      final iframe = web.document.createElement('iframe') as web.HTMLIFrameElement;
      iframe.src = webUrl;
      iframe.style.border = 'none';
      iframe.style.width = '100%';
      iframe.style.height = '100%';
      return iframe;
    });
  }
}
