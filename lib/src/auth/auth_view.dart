import 'package:flutter/material.dart';
import 'package:login_scanner/src/auth/auth_field_view.dart';
import 'package:login_scanner/src/layouts/admin_setup_layout.dart';

class AuthView extends StatelessWidget {
  const AuthView({
    super.key,
  });

  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    return AdminSetupLayout(child: AuthField());
  }
}

