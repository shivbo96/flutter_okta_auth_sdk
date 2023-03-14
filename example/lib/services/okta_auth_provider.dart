import 'package:flutter/material.dart';
import 'package:flutter_okta_auth/services/auth_okta_service.dart';

class OktaAuthProvider extends InheritedWidget {
  final AuthOktaService authService;

  const OktaAuthProvider(
      {Key? key, required this.authService, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static OktaAuthProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<OktaAuthProvider>();
}
