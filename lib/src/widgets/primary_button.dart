import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final VoidCallback onPressed;
  final String title;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  FocusNode buttonFocusNode = FocusNode();

  @override
  void dispose() {
    buttonFocusNode.dispose();
    debugPrint("does it dispose the button focus node correctly?");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      focusNode: buttonFocusNode,
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        primary: Color(0xFFd90a2c), 
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
          ),
      ),
    );
  }
}
