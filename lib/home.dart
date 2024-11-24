import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:web_view_demo/providers/wev_provider.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final webViewProvider = Provider.of<WebViewProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: webViewProvider.goBack,
          child: Column(
            children: [
              // Linear Progress Indicator
              if (webViewProvider.progress < 1.0)
                LinearProgressIndicator(value: webViewProvider.progress),

              // WebView
              Expanded(
                child: InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: WebUri(webViewProvider.currentUrl),
                  ),
                  onWebViewCreated: (controller) =>
                      webViewProvider.setController(controller),
                  onProgressChanged: (controller, progress) =>
                      webViewProvider.updateProgress(progress / 100),
                  onLoadStop: (controller, url) =>
                      webViewProvider.refreshController.endRefreshing(),
                  pullToRefreshController: webViewProvider.refreshController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
