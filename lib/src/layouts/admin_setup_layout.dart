import 'package:flutter/material.dart';

class AdminSetupLayout extends StatelessWidget {
  final Widget child;

  AdminSetupLayout({required this.child});

  @override
  Widget build(BuildContext context) {
    final double viewportHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          child
        ],
      ),
    );
  }
}
