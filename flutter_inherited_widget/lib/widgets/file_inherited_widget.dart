import 'dart:io';

import 'package:flutter/widgets.dart';

class FileInheritedWidget extends InheritedWidget {
  const FileInheritedWidget({
    Key key,
    @required this.file,
    @required Widget child,
  }) : super(key: key, child: child);

  final File file;

  static FileInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FileInheritedWidget>();
  }

  @override
  bool updateShouldNotify(FileInheritedWidget old) => file != old.file;
}
