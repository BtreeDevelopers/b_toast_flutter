import 'package:btoastflutter/widgets/b_toast.dart';
import 'package:flutter/material.dart';

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

class OverlayExample extends StatefulWidget {
  const OverlayExample({Key? key}) : super(key: key);

  @override
  State<OverlayExample> createState() => _OverlayExampleState();
}

class _OverlayExampleState extends State<OverlayExample>
    with TickerProviderStateMixin {
  BToast? bToast;

  @override
  void initState() {
    super.initState();
    bToast = BToast(context, this);
  }

  @override
  void dispose() {
    bToast?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    bToast?.show(
                      borderColor: Colors.red,
                    );
                  });
                },
                child: const Text('Explore'),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  bToast?.hide();
                },
                child: const Text('Remove Overlay'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
