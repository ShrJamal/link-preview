library link_preview;

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Element;
import 'package:html/dom.dart' hide Text;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:link_preview/model/meta_data.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

part 'link_preview.dart';
part 'web_parser.dart';

late SharedPreferences pref;

class LinkPreview extends StatefulWidget {
  final String link;
  final double? titleFontSize;
  final double? bodyFontSize;
  final Color backgroundColor;
  final Color? borderColor;
  final Color defaultPlaceholderColor;
  final double borderRadius;
  final Widget? placeholder;
  final bool showTitle;
  final bool showBody;
  final TextOverflow? bodyTextOverflow;
  final int? bodyMaxLines;
  final Color? titleTextColor;
  final Color? bodyTextColor;
  LinkPreview({
    Key? key,
    required this.link,
    this.titleFontSize,
    this.bodyFontSize,
    this.backgroundColor = Colors.white,
    this.borderColor,
    this.defaultPlaceholderColor = const Color.fromRGBO(235, 235, 235, 1.0),
    this.borderRadius = 3.0,
    this.placeholder,
    this.showTitle = true,
    this.showBody = true,
    this.bodyTextOverflow,
    this.bodyMaxLines,
    this.titleTextColor,
    this.bodyTextColor,
  }) : super(key: key);

  @override
  _LinkPreviewer createState() => _LinkPreviewer();
}

class _LinkPreviewer extends State<LinkPreview> {
  LinkMetaData? _metaData;
  late String _link = widget.link.trim();
  late bool isImage =
      lookupMimeType(widget.link)?.startsWith('image/') ?? false;

  @override
  Widget build(BuildContext context) {
    final _height = _computeHeight(MediaQuery.of(context).size.height);
    return Container(
      decoration: new BoxDecoration(
        color: widget.backgroundColor,
        border: Border.all(
          color: widget.borderColor == null
              ? widget.backgroundColor
              : widget.borderColor!,
          width: widget.borderColor == null ? 0.0 : 1.0,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(widget.borderRadius),
        ),
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
                  metaData: _metaData!,
                  onTap: _launchURL,
                  showTitle: widget.showTitle,
                  showBody: widget.showBody,
                  bodyTextOverflow: widget.bodyTextOverflow,
                  bodyMaxLines: widget.bodyMaxLines,
                ),
    );
  }

  @override
  void initState() {
    super.initState();

    _fetchData();
  }

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

  double _computeHeight(double screenHeight) => screenHeight * 0.25;

  void _fetchData() async {
    if (isImage) return;
    if (!_link.startsWith(RegExp(r"https?://"))) {
      _link = "https://$_link";
    }
    if (!isValidUrl(_link)) {
      throw Exception("Invalid link");
    } else {
      pref = await SharedPreferences.getInstance();
      var meta = pref.getString(_link);
      if (meta == null) {
        _metaData = await WebPageParser.getData(_link);
        pref.setString(_link, json.encode(_metaData!.toMap()));
      } else {
        _metaData = LinkMetaData.fromMap(json.decode(meta));
      }
      setState(() {});
    }
  }

  void _launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
