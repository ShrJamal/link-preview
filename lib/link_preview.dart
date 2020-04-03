part of link_preview;

class LinkPreviewWidget extends StatefulWidget {
  LinkPreviewWidget({
    Key key,
    @required this.url,
    @required this.metaData,
    @required this.onTap,
    this.titleFontSize,
    this.bodyFontSize,
    this.showTitle,
    this.showBody,
    this.bodyTextOverflow,
    this.bodyMaxLines,
  })  : assert(metaData != null),
        assert(url != null),
        assert(onTap != null),
        super(key: key);

  final String url;
  final LinkMetaData metaData;
  final Function onTap;
  final double titleFontSize;
  final double bodyFontSize;
  final bool showTitle;
  final bool showBody;
  final TextOverflow bodyTextOverflow;
  final int bodyMaxLines;

  @override
  _LinkPreviewWidgetState createState() => _LinkPreviewWidgetState();
}

class _LinkPreviewWidgetState extends State<LinkPreviewWidget> {
  double computeTitleFontSize(double height) {
    double size = height * 0.13;
    if (size > 15) {
      size = 15;
    }
    return size;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: InkWell(
        onTap: () => widget.onTap(widget.url),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: CachedNetworkImage(
                imageUrl: widget.metaData.image,
                fit: BoxFit.cover,
                width: double.infinity,
                errorWidget: (_, __, ___) => Container(
                  color: Color.fromRGBO(235, 235, 235, 1.0),
                ),
              ),
            ),
            if (widget.metaData.title.isNotEmpty && widget.showTitle == true)
              Padding(
                padding: const EdgeInsets.fromLTRB(4.0, 1.0, 3.0, 0.0),
                child: Container(
                  alignment: Alignment(-1.0, -1.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.metaData.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: widget.titleFontSize),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
            if (widget.metaData.title.isNotEmpty && widget.showBody == true)
              Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 4.0),
                child: Text(
                  widget.metaData.description,
                  style: TextStyle(
                      fontSize: widget.bodyFontSize, color: Colors.grey),
                  overflow: widget.bodyTextOverflow == null
                      ? TextOverflow.fade
                      : widget.bodyTextOverflow,
                  maxLines: 5,
                ),
              )
          ],
        ),
      ),
    );
  }
}
