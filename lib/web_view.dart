import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewDemo extends StatefulWidget {
  const WebViewDemo({super.key});

  @override
  State<WebViewDemo> createState() => _WebViewDemoState();
}

class _WebViewDemoState extends State<WebViewDemo> {
  var _isLoading = false;
  final _webViewController = WebViewController()

  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..loadRequest(Uri.parse("https://w7ds.com/"));
  Future<void> _refreshData() async {
    try {
      // Set loading state
      setState(() {
        _isLoading = true;
      });

      // Actually reload the WebView
      await _webViewController.reload();

      // Ensure loading state is reset
      await Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            _isLoading = true;
          });
        }
      });
    } catch (e) {
      // Handle any potential errors
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to refresh: $e')),
        );

        setState(() {
          _isLoading = false;
        });
      }
    }
  }
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
          child: LiquidPullToRefresh(

            onRefresh: _refreshData,
            child: Stack(
              children: [
                Column(

                  children: [
                    Expanded(
                      child: WebViewWidget(

                          controller: _webViewController),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
