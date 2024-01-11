import 'package:flutter/material.dart';
import 'package:login_scanner/src/layouts/admin_setup_layout.dart';
import 'package:login_scanner/src/scan/qr_listener.dart';

class ScanViews extends StatelessWidget {
  const ScanViews({super.key});

  static const routeName = "/scan";

  @override
  Widget build(BuildContext context) {
    return AdminSetupLayout(
      child: SizedBox(
        width: 400,
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center ,
          children: [
            Text('Scan a QR code.'),
              
            QrReaderView(),
          ],
        ),
      )
    );
  }
}