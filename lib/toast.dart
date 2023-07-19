import 'package:flutter/material.dart';

class Toast {
  static void show(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2), // Duração do toast
      ),
    );
  }
}
