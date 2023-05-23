import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ItemView extends StatefulWidget {
  final String title, url, author;
  const ItemView(
      {required this.title,
      required this.author,
      required this.url,
      super.key});

  @override
  // ignore: no_logic_in_create_state
  State<ItemView> createState() => _ItemViewState(title, author, url);
}

class _ItemViewState extends State<ItemView> {
  final String title, author, url;
  _ItemViewState(this.title, this.author, this.url);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: WebViewWidget(
          controller: WebViewController()..loadRequest(Uri.parse(url))),
    );
  }
}
