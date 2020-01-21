import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'widgets/clock_widget.dart';
import 'widgets/file_inherited_widget.dart';
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

class _ClockHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ClockHomePageState();
  }
}

class _ClockHomePageState extends State<_ClockHomePage> {
  File _imageFile;

  _pickImage() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = imageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: <Widget>[
            Container(
              child: FileInheritedWidget(
                child: WallpaperWidget(),
                file: _imageFile,
              ),
            ),
            Container(
              child: Center(
                child: ClockWidget(),
              ),
            ),
          ],
        ),
        onTap: () => _pickImage(),
      ),
    );
  }
}
