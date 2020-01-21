import 'package:flutter/widgets.dart';

import 'file_inherited_widget.dart';

class WallpaperWidget extends StatefulWidget {
  WallpaperWidget({Key key}) : super(key: key);

  @override
  State<WallpaperWidget> createState() {
    return _WallpaperWidgetState();
  }
}

class _WallpaperWidgetState extends State<WallpaperWidget> {
  @override
  Widget build(BuildContext context) {
    var imageFile = FileInheritedWidget.of(context).file;
    Image image;

    if (imageFile != null) {
      image = Image.file(imageFile, fit: BoxFit.cover);
    }

    return Container(
      constraints: BoxConstraints.expand(),
      child: image,
    );
  }
}
