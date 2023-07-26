import 'package:flutter/material.dart';

import '../widgets/b_toast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OverlayEntry Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Show the overlay when the button is pressed
            ComponentLinearProgressOverlay.show(context);

            // Simulate hiding the overlay after 5 seconds (5000 milliseconds)
          },
          child: Text('Show Overlay'),
        ),
      ),
    );
  }
}
