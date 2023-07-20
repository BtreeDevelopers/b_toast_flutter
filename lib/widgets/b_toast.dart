import 'package:flutter/material.dart';

class BToast {
  final BuildContext context;
  OverlayEntry? overlayEntry;
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;

  BToast(this.context, self) {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: self,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
  }

  void show({
    required Color borderColor,
  }) {
    hide();

    assert(overlayEntry == null);

    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return SafeArea(
          child: Align(
            alignment: AlignmentDirectional.topStart,
            heightFactor: 1.0,
            widthFactor: 1,
            child: SlideTransition(
              position: _offsetAnimation,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: const Color(0xff252831),
                          border: Border.all(
                            color: borderColor,
                            width: 4.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Expanded(
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
                              GestureDetector(
                                onTap: () {
                                  hide();
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: Color(0xffC6C6C6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedPositioned(
                      duration: Duration(milliseconds: 500),
                      left: 0,
                      right: (1.0 - _controller.value) * 200.0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 8,
                        decoration: BoxDecoration(
                            color: borderColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    // Future.delayed(Duration(seconds: 5)).then((value) {
    //   hide();
    // });

    _controller.forward();
    Overlay.of(context).insert(overlayEntry!);
  }

  void hide() {
    if (overlayEntry != null) {
      _controller.reverse().then((value) {
        overlayEntry?.remove();
        overlayEntry = null;
      });
    }
  }

  void dispose() {
    hide();
    _controller.dispose();
  }
}
