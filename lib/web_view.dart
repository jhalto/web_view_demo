import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewDemo extends StatefulWidget {
  const WebViewDemo({super.key});

  @override
  State<WebViewDemo> createState() => _WebViewDemoState();
}

class _WebViewDemoState extends State<WebViewDemo> {



  final WebViewController _webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse("https://w7ds.com/"));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            if (await _webViewController.canGoBack()) {
              await _webViewController.goBack();
              return false; // Prevent popping the screen when navigating back in WebView
            }
            return true; // Allow the screen to pop if no web history is present
          },
          child: WebViewWidget(controller: _webViewController,


          )

        ),
      ),
    );
  }

}
