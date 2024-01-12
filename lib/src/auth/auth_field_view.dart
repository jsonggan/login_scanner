import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_scanner/src/auth/auth_button_view.dart';
import 'package:login_scanner/src/auth/auth_text_field_view.dart';
import 'package:login_scanner/src/auth/auth_title_view.dart';

class AuthField extends StatefulWidget {
  const AuthField({
    super.key,
  });


  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  String _url = '';
  String _api_key = '';

  void _updatePin(String newPin) {
    setState(() {
      _url = newPin;
    });
  }

  void _updateApiKey(String newApiKey) {
    setState(() {
      _api_key = newApiKey;
    });
  }

  void _signIn() async {
    // call to api
    if (_url.isNotEmpty && _api_key.isNotEmpty) {
      final storage = new FlutterSecureStorage();
      await storage.write(key: 'url', value: _url);
      await storage.write(key: 'api_key', value: _api_key);
      Navigator.pushReplacementNamed(context, '/scan');
    } else {
      Fluttertoast.showToast(
        msg: "Please key in the url and api key",  
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM_RIGHT,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.grey[800],
        textColor: Colors.white,
        fontSize: 20.0
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment : MainAxisAlignment.center,
        children: <Widget>[
          const AuthTitleView(),
          const SizedBox(height: 20.0),
          AuthTextFieldView(
            onTextChanged: _updatePin,
            label: "URL"
          ),
          const SizedBox(height: 20.0),
          AuthTextFieldView(
            onTextChanged: _updateApiKey,
            label: "API KEY"
          ),
          const SizedBox(height: 16.0),
          AuthButtonView(
            onSignInPressed: _signIn,
            pin: _url),
        ],
      ),
    );
  }
}

