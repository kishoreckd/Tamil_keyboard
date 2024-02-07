import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// ignore_for_file: unused_local_variable


class WebViewScreen extends StatefulWidget {
  final String url;
  final String name;

  const WebViewScreen({
    super.key,
    required this.url,
    required this.name,
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.name),
      ),
      body: Stack(children: [
        InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
          onLoadError: (controller, url, code, message) {},
          onLoadStart: (controller, url) {
            setState(() {
              isLoading = true;
            });
          },
          onLoadStop: (controller, url) {
            setState(() {
              isLoading = false;
            });
          },
        ),
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(),
          )
      ]),
    );
  }
}
