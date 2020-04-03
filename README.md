# link_preview

A new Flutter package. Build container with image, title, description from web-site (link) will be provided.


## Installing 
Use this package as a library
1. Depend on it

Add this to your package's pubspec.yaml file:


```yaml
dependencies:
  link_preview: ^0.0.1
```

2. Install it

You can install packages from the command line:
with Flutter:

```
$ flutter pub get
```

Alternatively, your editor might support flutter pub get. Check the docs for your editor to learn more.

3. Import it

Now in your Dart code, you can use:

```dart
import 'package:link_preview/previewer.dart';
```

## Usage

```dart
Widget build() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      LinkPreview(
        link: "https://www.linkedin.com/feed/",
        direction: ContentDirection.horizontal,
      ),
    ],
  );
}
```

