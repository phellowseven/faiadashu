import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

Widget createWebView(String xhtml, {Key? key}) => _FullHtmlViewer(
      xhtml,
      key: key,
    );

class _FullHtmlViewer extends StatefulWidget {
  final String xhtml;

  const _FullHtmlViewer(
    this.xhtml, {
    super.key,
  });

  @override
  State<_FullHtmlViewer> createState() => _FullHtmlViewerState();
}

class _FullHtmlViewerState extends State<_FullHtmlViewer> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    late final PlatformWebViewControllerCreationParams params;
    params = const PlatformWebViewControllerCreationParams();
    _controller = WebViewController.fromPlatformCreationParams(params);
    final dataUrl = Uri.dataFromString(
      widget.xhtml,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString();

    _controller.loadHtmlString(dataUrl);
  }

  @override
  Widget build(BuildContext context) {
    // required while web support is in preview
    // WebView.platform = WebWebViewPlatform();

    return SizedBox.expand(
      child: WebViewWidget(
        controller: _controller,
        // initialUrl: dataUrl,
      ),
    );
  }
}
