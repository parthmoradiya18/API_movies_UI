import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Movies_Page extends StatefulWidget {
  String? movie;
  String? Name;

  Movies_Page([this.movie, this.Name]);

  @override
  State<Movies_Page> createState() => _Movies_PageState();
}

class _Movies_PageState extends State<Movies_Page> {
  String? Url;
  double Progress = 0;
  InAppWebViewController? web;
  String? current;
  bool ForWord = false;
  bool Back = false;
  PullToRefreshController? Refresh;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Refresh = PullToRefreshController(
      onRefresh: () {
        web!.reload();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          (Back)
              ? IconButton(
            onPressed: () async {
              if (web != null) {
                await web!.goBack();
              }
              setState(() {});
            },
            icon: const Icon(size: 20,
              Icons.arrow_back,
              color: Colors.white,
            ),
          )
              : Container(),
          IconButton(
            onPressed: () async {
              if (web != null) {
                await web!.reload();
              }
              setState(() {});
            },
            icon: const Icon(size: 20,
              Icons.refresh,
            ),
          ),
          (ForWord)
              ? IconButton(
            onPressed: () async {
              if (web != null) {
                await web!.goForward();
              }
            },
            icon: const Icon(size: 20,
              Icons.arrow_right,
              color: Colors.white,
            ),
          )
              : Container(),
        ],
        centerTitle: true,
        backgroundColor: Colors.indigo[300],
        title: Text(
          "${widget.Name}",
          style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: Progress,
            backgroundColor: Colors.blue,
          ),
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: Uri.parse(widget.movie!),
              ),
              pullToRefreshController: Refresh,
              onWebViewCreated: (controller) {
                setState(() {
                  web = controller;
                });
              },
              onLoadStart: (controller, url) async {
                setState(() {
                  current = url.toString();
                });
                ForWord = await web!.canGoForward();
                Back = await web!.canGoBack();
                setState(() {});
              },
              onLoadStop: (controller, url) async {
                setState(() {
                  current = url.toString();
                });
                ForWord = await web!.canGoForward();
                Back = await web!.canGoBack();
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
