import 'package:flutter/material.dart';
import 'package:flutter_okta_auth/services/auth_okta_service.dart';

class OktaAuthProvider extends InheritedWidget {
  final AuthOktaService authService;

  const OktaAuthProvider({super.key, required this.authService, required super.child});

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static OktaAuthProvider? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<OktaAuthProvider>();
}
