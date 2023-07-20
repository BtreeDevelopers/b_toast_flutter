import 'dart:math';

import 'package:flutter/material.dart';

/// Flutter code sample for [Overlay].

void main() => runApp(const OverlayApp());

class OverlayApp extends StatefulWidget {
  const OverlayApp({super.key});

  @override
  State<OverlayApp> createState() => _OverlayAppState();
}

class _OverlayAppState extends State<OverlayApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: OverlayExample(),
    );
  }
}

class OverlayExample extends StatefulWidget {
  const OverlayExample({super.key});

  @override
  State<OverlayExample> createState() => _OverlayExampleState();
}

class _OverlayExampleState extends State<OverlayExample>
    with TickerProviderStateMixin {
  OverlayEntry? overlayEntry;
  int currentPageIndex = 0;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(1.0, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  ));

  Future<void> createHighlightOverlay({
    required AlignmentDirectional alignment,
    required Color borderColor,
  }) async {
    // Remove the existing OverlayEntry.
    removeHighlightOverlay();

    assert(overlayEntry == null);

    overlayEntry = OverlayEntry(
      // Create a new OverlayEntry.
      builder: (BuildContext context) {
        // Align is used to position the highlight overlay
        // relative to the NavigationBar destination.
        return SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: 1.0,
            widthFactor: 1,
            child: SlideTransition(
              position: _offsetAnimation,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: const Color(0xff252831),
                      border: Border.all(
                        color: borderColor,
                        width: 4.0,
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Text(
                                'Explore page',
                                style: TextStyle(
                                  color: Color(0xffC6C6C6),
                                  fontSize: 14.0,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.close,
                            color: Color(0xffC6C6C6),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    //REMOVER TOAST
    Future.delayed(Duration(seconds: 2))
        .then((value) => removeHighlightOverlay());

    // Add the OverlayEntry to the Overlay.
    Future.delayed(Duration.zero).then((value) {
      _controller.forward();
      Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
    });
  }

  // Remove the OverlayEntry.
  Future<void> removeHighlightOverlay() async {
    if (overlayEntry != null) {
      _controller.reverse().then((value) {
        overlayEntry?.remove();
        overlayEntry = null;
        // _controller.dispose();
      });
    }
  }

  @override
  void dispose() {
    // Make sure to remove OverlayEntry when the widget is disposed.
    removeHighlightOverlay();
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
                    currentPageIndex = 0;
                  });
                  createHighlightOverlay(
                    alignment: AlignmentDirectional.topStart,
                    borderColor: Colors.red,
                  );
                },
                child: const Text('Explore'),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  removeHighlightOverlay();
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
