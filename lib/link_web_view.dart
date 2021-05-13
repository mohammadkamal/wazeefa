import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LinkWebView extends StatefulWidget {
  final String link;

  const LinkWebView({Key key, @required this.link}) : super(key: key);
  _LinkWebViewState createState() => _LinkWebViewState();
}

class _LinkWebViewState extends State<LinkWebView> {
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.link);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.link),
      ),
      body: WebView(initialUrl: widget.link),
    );
  }
}
