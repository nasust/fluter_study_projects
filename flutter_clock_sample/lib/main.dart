import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'widgets/clock_widget.dart';
import 'widgets/wallpaper_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clock',
      theme: ThemeData.dark(),
      home: _ClockHomePage(),
    );
  }
}

class _ClockHomePage extends StatelessWidget {
  final _key = new GlobalKey<WallpaperWidgetState>();

  _pickImage() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    _key.currentState.imageFile = imageFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: <Widget>[
            Container(child: WallpaperWidget(key: _key)),
            Container(child: Center(child: ClockWidget())),
          ],
        ),
        onTap: () => _pickImage(),
      ),
    );
  }
}
