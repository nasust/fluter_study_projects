import 'dart:io';

import 'package:flutter/widgets.dart';

class WallpaperWidget extends StatefulWidget {
  WallpaperWidget({Key key}) : super(key: key);

  @override
  State<WallpaperWidget> createState() {
    return WallpaperWidgetState();
  }
}

class WallpaperWidgetState extends State<WallpaperWidget> {
  Image _image;

  set imageFile(File imageFile) {
    setState(() {
      _image = Image.file(imageFile,fit: BoxFit.cover);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: _image,
    );
  }
}
