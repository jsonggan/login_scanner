import 'package:flutter/material.dart';
import 'package:login_scanner/src/widgets/primary_button.dart';

class AuthButtonView extends StatelessWidget {
  const AuthButtonView({
    super.key,
    required this.pin,
    required this.onSignInPressed
  });

  final String pin;
  final Function() onSignInPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 300,
          child: PrimaryButton(
            title: "Sign In",
            onPressed: onSignInPressed,),
        ),
      ],
    );
  }
}

