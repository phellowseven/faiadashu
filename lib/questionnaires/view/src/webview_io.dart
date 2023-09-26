import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:webview_flutter/webview_flutter.dart';

Widget createWebView(String xhtml, {Key? key}) =>
    Platform.isAndroid || Platform.isIOS
        ? _FullHtmlViewer(
            xhtml,
            key: key,
          )
        : _SimpleHtmlViewer(
            xhtml,
            key: key,
          );

class _FullHtmlViewer extends StatefulWidget {
  final String xhtml;

  const _FullHtmlViewer(this.xhtml, {super.key});

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
    return SizedBox.expand(
      child: WebViewWidget(
        controller: _controller,

        // child: WebView(
        //   initialUrl: dataUrl,
      ),
    );
  }
}

class _SimpleHtmlViewer extends StatelessWidget {
  final String xhtml;

  const _SimpleHtmlViewer(this.xhtml, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: SingleChildScrollView(
        child: HTML.toRichText(
          context,
          xhtml,
          defaultTextStyle: Theme.of(context).textTheme.bodyText2,
        ),
      ),
    );
  }
}
