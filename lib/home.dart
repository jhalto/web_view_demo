import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:web_view_demo/widget/custom_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late var url;
  InAppWebViewController? webViewController;
  PullToRefreshController? refreshController;
  double progress = 0;
  final String initialUrl = "https://w7ds.com/"; // Use final since it won't change
  Future<bool> _goBack(BuildContext context)async{
    if(await webViewController!.canGoBack()){
      webViewController!.goBack();
      return Future.value(false);
    }else{
      SystemNavigator.pop();
      return Future.value(true);
    }
  }
  @override
  void initState() {

    super.initState();
    refreshController = PullToRefreshController(
      onRefresh: () {
        webViewController!.reload();
      },
      // options: PullToRefreshOptions(
      //   color: Colors.white,
      //       backgroundColor: Colors.black
      // )
    );
  }
  // var isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () => _goBack(context),
          child: Column(
            children: [
              Expanded(
                // child: Stack(
                //   children: [
                   child:  InAppWebView(
                      // onLoadStart: (controller, url) {
                      //   setState(() {
                      //     isLoading = true;
                      //   });
                      // },
                      onLoadStop: (controller, url) {
                        refreshController!.endRefreshing();
                        // setState(() {
                        //   isLoading = false;
                        // });
                      } ,
                      pullToRefreshController: refreshController,
                      onWebViewCreated: (controller) => webViewController = controller,
                      initialUrlRequest: URLRequest(
                        url: WebUri(initialUrl), // Pass the String directly to WebUri
                      ),
                       
                    ),
                    // Visibility(child: spinkit,
                    //   visible: isLoading,
                    //
                    // )
                //   ],
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
