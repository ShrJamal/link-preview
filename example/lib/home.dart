import 'package:flutter/material.dart';
import 'package:link_preview/previewer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LinkPreview(
              link: 'https://www.google.com',
            ),
            LinkPreview(
              link: 'https://www.youtube.com',
            ),
          ],
        ),
      ),
    );
  }
}
