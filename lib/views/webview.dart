// ignore_for_file: unused_element

import 'package:appdoctrina/values/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key, required this.url});

  final String url;

  @override
  State<StatefulWidget> createState() => _WebViewPage();
}

class _WebViewPage extends State<WebViewPage> {
  late WebViewController _controller;
  var loadingPercentage = 0;
  var error = false;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController();
    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    _controller.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) => setState(() => loadingPercentage = 0),
        onProgress: (int progress) =>
            setState(() => loadingPercentage = progress),
        onPageFinished: (String url) => setState(() => loadingPercentage = 100),
        onWebResourceError: (WebResourceError error) =>
            setState(() => this.error = true),
        onNavigationRequest: (NavigationRequest request) =>
            NavigationDecision.navigate,
      ),
    );
    if (widget.url.isNotEmpty) _controller.loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.url.isEmpty || error == true) {
      return const Center(child: Text("Error."));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.url),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (loadingPercentage < 100)
            Center(
                child: CircularProgressIndicator(
              strokeWidth: 6.0,
              value: loadingPercentage / 100,
              valueColor: const AlwaysStoppedAnimation<Color>(MyColors.azul),
            )),
        ],
      ),
    );
  }
}
