import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  const WebView({super.key});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
final _webViewController = WebViewController()

  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..loadRequest(Uri.parse("https://w7ds.com/"));
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: PopScope(
        onPopInvoked: (value)async{
          if(await _webViewController.canGoBack()){
            await _webViewController.goBack();
          }
        },
          canPop: true,
          child: WebViewWidget(controller: _webViewController)
      ),
    );
  }
}
