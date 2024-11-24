import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewProvider with ChangeNotifier {
  InAppWebViewController? _webViewController;
  double _progress = 0.0;
  String _currentUrl = "https://w7ds.com/";

  late PullToRefreshController refreshController;

  WebViewProvider() {
    refreshController = PullToRefreshController(
      onRefresh: () async {
        if (_webViewController != null) {
          await _webViewController!.reload();
        }
        refreshController.endRefreshing(); // End refreshing after reload
      },
    );
  }

  String get currentUrl => _currentUrl;
  double get progress => _progress;

  void setController(InAppWebViewController controller) {
    _webViewController = controller;
  }

  void updateProgress(double progress) {
    _progress = progress;
    notifyListeners();
  }

  Future<void> refreshPage() async {
    if (_webViewController != null) {
      await _webViewController!.reload();
    }
    refreshController.endRefreshing();
  }

  Future<bool> goBack() async {
    if (await _webViewController?.canGoBack() ?? false) {
      await _webViewController?.goBack();
      return false;
    }
    return true;
  }

  void setCurrentUrl(String url) {
    _currentUrl = url;
    notifyListeners();
  }
}
