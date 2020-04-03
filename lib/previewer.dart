library link_preview;

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:link_preview/model/meta_data.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' hide Text;
import 'package:flutter/material.dart' hide Element;
import 'dart:async';

part 'web_parser.dart';
part 'link_preview.dart';

class LinkPreview extends StatefulWidget {
  LinkPreview({
    Key key,
    @required this.link,
    this.titleFontSize,
    this.bodyFontSize,
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.deepOrangeAccent,
    this.defaultPlaceholderColor,
    this.borderRadius,
    this.placeholder,
    this.showTitle = true,
    this.showBody = true,
    this.bodyTextOverflow,
    this.bodyMaxLines,
    this.titleTextColor,
    this.bodyTextColor,
  })  : assert(link != null),
        super(key: key);

  final String link;
  final double titleFontSize;
  final double bodyFontSize;
  final Color backgroundColor;
  final Color borderColor;
  final Color defaultPlaceholderColor;
  final double borderRadius;
  final Widget placeholder;
  final bool showTitle;
  final bool showBody;
  final TextOverflow bodyTextOverflow;
  final int bodyMaxLines;
  final Color titleTextColor;
  final Color bodyTextColor;

  @override
  _LinkPreviewer createState() => _LinkPreviewer();
}

SharedPreferences pref;

class _LinkPreviewer extends State<LinkPreview> {
  LinkMetaData _metaData;
  double _height;
  String _link;
  Color _placeholderColor;
  bool isImage;

  @override
  void initState() {
    super.initState();
    isImage = lookupMimeType(widget.link)?.startsWith('image/') ?? false;
    if (isImage) return;
    _link = widget.link.trim();
    if (!_link.startsWith(RegExp(r"https?://"))) {
      _link = "https://$_link";
    }
    _placeholderColor ??= Color.fromRGBO(235, 235, 235, 1.0);
    _fetchData();
  }

  void _fetchData() async {
    if (!isValidUrl(_link)) {
      throw Exception("Invalid link");
    } else {
      pref ??= await SharedPreferences.getInstance();
      var meta = pref.getString(_link);
      if (meta == null) {
        _metaData = await WebPageParser.getData(_link);
        pref.setString(_link, json.encode(_metaData.toJson()));
      } else {
        _metaData = LinkMetaData.fromJson(json.decode(meta));
      }
      setState(() {});
    }
  }

  double _computeHeight(double screenHeight) => screenHeight * 0.25;

  bool isValidUrl(link) {
    String regexSource =
        "^(https?)://[-a-zA-Z0-9+&@#/%?=~_|!:,.;]*[-a-zA-Z0-9+&@#/%=~_|]";
    final regex = RegExp(regexSource);
    final matches = regex.allMatches(link);
    for (Match match in matches) {
      if (match.start == 0 && match.end == link.length) {
        return true;
      }
    }
    return false;
  }

  void _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    _height = _computeHeight(MediaQuery.of(context).size.height);
    return Container(
      decoration: new BoxDecoration(
        color: widget.backgroundColor,
        border: Border.all(
          color: widget.borderColor == null
              ? widget.backgroundColor
              : widget.borderColor,
          width: widget.borderColor == null ? 0.0 : 1.0,
        ),
        borderRadius: BorderRadius.all(Radius.circular(
            widget.borderRadius == null ? 3.0 : widget.borderRadius)),
      ),
      height: _height,
      child: isImage
          ? CachedNetworkImage(
              imageUrl: widget.link,
              fit: BoxFit.cover,
            )
          : _metaData == null
              ? null
              : LinkPreviewWidget(
                  url: _link,
                  metaData: _metaData,
                  onTap: _launchURL,
                  showTitle: widget.showTitle,
                  showBody: widget.showBody,
                  bodyTextOverflow: widget.bodyTextOverflow,
                  bodyMaxLines: widget.bodyMaxLines,
                ),
    );
  }
}
