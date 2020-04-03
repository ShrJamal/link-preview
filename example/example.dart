import 'package:flutter/material.dart';
import 'package:link_preview/previewer.dart';

void main() {
  runApp(ExampleApp());
}

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LinkPreviewerExample(),
    );
  }
}

class LinkPreviewerExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LinkPreview(
            link: "https://www.linkedin.com/feed/",
            borderRadius: 14,
          ),
        ],
      ),
    );
  }
}
