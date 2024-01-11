import 'package:flutter/material.dart';
import 'package:login_scanner/src/layouts/admin_setup_layout.dart';

class ScanViews extends StatelessWidget {
  const ScanViews({super.key});

  static const routeName = "/scan";

  @override
  Widget build(BuildContext context) {
    return AdminSetupLayout(
      child: Text('this is a page to scan qr')
    );
  }
}