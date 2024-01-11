import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QrReaderView extends StatefulWidget {
  const QrReaderView({
    super.key,
  });

  @override
  State<QrReaderView> createState() => _QrReaderViewState();
}

class _QrReaderViewState extends State<QrReaderView> {
  final FocusNode _focusNode = FocusNode();
  String _scannedCode = '';

  static const platform = MethodChannel('com.test/keyboard');
  Future<void> hideSoftKeyboard() async {
    try {
      final String result = await platform.invokeMethod('hide');
      debugPrint(result);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void dispose() {
    // _focusNode.dispose();
    super.dispose();
  }

  void _handleKey(RawKeyEvent event) {
    hideSoftKeyboard();
    if (event is RawKeyDownEvent) {
      final key = event.data.logicalKey;

      if (key == LogicalKeyboardKey.enter) {
        // Do something when ENTER key is pressed
        print('Scanned QR Code: $_scannedCode');
        setState(() {
          _scannedCode = '';
        });
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        Navigator.pushNamed(context, "/success");
        
      } else {
        // Check if the key is a character key
        final String keyLabel = key.keyLabel;
        if (keyLabel.length == 1 && event.data is RawKeyEventDataAndroid) {
          final RawKeyEventDataAndroid data = event.data as RawKeyEventDataAndroid;
          String char = keyLabel;
          
          // Handle shift key for capitalization
          if (data.isShiftPressed) {
            char = char.toUpperCase();
          } else {
            char = char.toLowerCase();
          }
          
          setState(() {
            _scannedCode += char;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: _focusNode,
      onKey: _handleKey,
      child: Container(),
    );
  }
}