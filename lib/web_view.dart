import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  const WebView({super.key});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {

  final controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.disabled)
  ..loadRequest(Uri.parse("https://w7ds.com/"));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Web View"),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
