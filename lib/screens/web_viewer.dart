import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InShortsWebViewer extends StatefulWidget {
  final String url;
  static String routeName = "/web-viewer";

  const InShortsWebViewer({Key? key, required this.url}) : super(key: key);

  @override
  State<InShortsWebViewer> createState() => _InShortsWebViewerState();
}

class _InShortsWebViewerState extends State<InShortsWebViewer> {
  int loadingProgress = 0;
  bool isLoading = false;
  String title = "ProDT assignment by Bibek";

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            setState(() {
              loadingProgress = progress;
            });
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
              loadingProgress = 0;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
              loadingProgress = 0;
            });
          },
          onNavigationRequest: (NavigationRequest request) async {
            getTitle();
            return NavigationDecision.navigate;
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    getTitle();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : WebViewWidget(
              controller: controller,
            ),
    );
  }

  void getTitle() async {
    await controller.getTitle().then((value) => setState(() {
          title = value ?? "unknown";
        }));
  }
}
