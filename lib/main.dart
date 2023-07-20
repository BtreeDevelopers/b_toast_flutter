import 'package:flutter/material.dart';
import 'screens/overlay_example.dart';

void main() => runApp(const OverlayApp());

class OverlayApp extends StatelessWidget {
  const OverlayApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OverlayExample(),
    );
  }
}
