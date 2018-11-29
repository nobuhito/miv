import 'package:flutter/material.dart';

class WSpaceBox extends SizedBox {
  WSpaceBox({double width = 8, double height = 8})
      : super(width: width, height: height);

  WSpaceBox.width([double value = 8]) : super(width: value);
  WSpaceBox.height([double value = 8]) : super(height: value);
}
