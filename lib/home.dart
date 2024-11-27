import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
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
                  initialSettings: InAppWebViewSettings(
                    javaScriptEnabled: true,
                    cacheEnabled: true,
                    domStorageEnabled: true,
                    cacheMode: CacheMode.LOAD_DEFAULT,
                    safeBrowsingEnabled: true,
                  ),
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
                  shouldOverrideUrlLoading: (controller, navigationAction) async {
                    final uri = navigationAction.request.url;

                    if (uri != null && (uri.scheme == "fb" || uri.scheme == "intent")) {
                      // Handle deep links
                      try {
                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                      } catch (e) {
                        print("Failed to open deep link: $e");
                      }
                      return NavigationActionPolicy.CANCEL;
                    }

                    return NavigationActionPolicy.ALLOW;
                  },
                  onConsoleMessage: (controller, consoleMessage) {
                    print("JavaScript Console: ${consoleMessage.message}");
                  },
                  onLoadError: (controller, url, code, description) {
                    print("Failed to load: $url, Error: $description");
                    controller.loadUrl(
                      urlRequest: URLRequest(url: WebUri("https://example.com/error")),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
