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
        child: Row(
          children: [
            ElevatedButton(
              onPressed: () {
                // Show the overlay when the button is pressed
                BToast.show(context, "teste talao",
                    duration: 20, theme: Type.WARNING, isDark: true);

                // Simulate hiding the overlay after 5 seconds (5000 milliseconds)
              },
              child: Text('Show Overlay'),
            ),
            ElevatedButton(
              onPressed: () {
                // Show the overlay when the button is pressed
                BToast.hide();

                // Simulate hiding the overlay after 5 seconds (5000 milliseconds)
              },
              child: Text('Remove All'),
            ),
          ],
        ),
      ),
    );
  }
}
