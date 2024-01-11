import 'package:flutter/material.dart';

class AuthTextFieldView extends StatefulWidget {
  const AuthTextFieldView({
    super.key,
    required this.onTextChanged,
    required this.label,
  });

  final Function(String) onTextChanged;
  final String label;

  @override
  State<AuthTextFieldView> createState() => _AuthTextFieldViewState();
}

class _AuthTextFieldViewState extends State<AuthTextFieldView> {
  FocusNode textFocusNode = FocusNode();
  
  @override
  void dispose() {
    // debugDumpFocusTree();
    textFocusNode.dispose();
    // debugDumpFocusTree();
    debugPrint("does it dispose the focus node correctly?");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 300,
          child: TextFormField(
            focusNode: textFocusNode,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFd90a2c),
                  width: 1.0
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFd90a2c),
                  width: 1.0
                )),
              labelText: widget.label,
            ),
            obscureText: false,
            onChanged: (value) {
              widget.onTextChanged(value);
            }
          ),
        ),
      ],
    );
  }
}

