part of link_preview;

class WebPageParser {
  static String addWWWPrefixIfNotExists(String uri) {
    if (uri.isEmpty) return uri;
    final parsedUri = Uri.parse(uri);
    if (!parsedUri.host.startsWith('www')) {
      return parsedUri.replace(host: 'www.' + parsedUri.host).toString();
    }
    return '';
  }

  static Future<LinkMetaData?> getData(String url) async {
    final response = await http.get(Uri.parse(url));
    return getDataFromResponse(response, url);
  }

  static LinkMetaData? getDataFromResponse(http.Response response, String url) {
    var requiredAttributes = ['title', 'image', 'description'];
    if (response.statusCode == 200) {
      var data = {};
      var document = parser.parse(response.body);
      var openGraphMetaTags = _getOgPropertyData(document);

      openGraphMetaTags.forEach((element) {
        var ogTagTitle = element.attributes['property']?.split("og:")[1];
        var ogTagValue = element.attributes['content'] ?? '';
        if (requiredAttributes.contains(ogTagTitle)) {
          if (ogTagTitle == "image" &&
              !ogTagValue.startsWith(RegExp(r'https?://'))) {
            data[ogTagTitle] = "https://" + _extractHost(url) + ogTagValue;
          } else {
            data[ogTagTitle] = ogTagValue;
          }
        }
      });
      final meta = LinkMetaData.fromMap({...data});
      return meta.copyWith.call(
        title: meta.title.isEmpty ? _scrapeTitle(document) : meta.title,
        description: meta.description.isEmpty
            ? _scrapeDescription(document)
            : meta.description,
        image: meta.image.isEmpty ? _scrapeImage(document, url) : meta.image,
      );
    }
    return null;
  }

  static String _extractHost(String link) {
    Uri uri = Uri.parse(link);
    return uri.host;
  }

  static List<Element> _getOgPropertyData(Document document) {
    return document.head?.querySelectorAll("[property*='og:']") ?? [];
  }

  static String _scrapeDescription(Document document) {
    try {
      final meta = document.getElementsByTagName("meta");
      final metaDescription = meta.firstWhere(
        (e) => e.attributes["name"] == "description",
      );

      return metaDescription.attributes["content"] ?? '';
    } catch (e) {
      return '';
    }
  }

  static String _scrapeImage(Document document, String url) {
    final images = document.body?.getElementsByTagName("img") ?? [];
    var imageSrc = "";
    if (images.isNotEmpty) {
      imageSrc = images[0].attributes["src"] ?? '';
      if (!imageSrc.startsWith("http")) {
        imageSrc = "http://" + _extractHost(url) + imageSrc;
      }
    }
    if (imageSrc == "") {
      print("WARNING - WebPageParser - " + url);
      print(
          "WARNING - WebPageParser - image might be empty. Tag <img> was not found.");
    }
    return imageSrc;
  }

  static String _scrapeTitle(Document document) {
    final ele = document.head?.getElementsByTagName("title") ?? [];
    return ele.isEmpty ? "" : ele[0].text;
  }
}
