import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'landing_screen.dart';
import 'services/okta_auth_provider.dart';
import 'package:crypto/crypto.dart';
// import 'dart:js' as js;

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            if (kIsWeb) {
              // var codeVerifier = getRandomString(50);
              // js.context.callMethod(
              //     'loginOkta', [transformCodeChallenge(codeVerifier)]);
            } else {
              await OktaAuthProvider.of(context)?.authService.authorize();
              var isAuthenticated = await OktaAuthProvider.of(context)
                  ?.authService
                  .isAuthenticated();
              if (isAuthenticated == true) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('you are authenticated by okta'),
                  duration: Duration(seconds: 2),
                ));
                Navigator.of(context).pushNamed(LandingScreen.routeName);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('you are not authenticated by okta'),
                  duration: Duration(seconds: 2),
                ));
              }
            }
          },
          child: const Text('Log In'),
        ),
      ),
    );
  }
}

final _rnd = Random();
const _chars =
    'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890_';

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

String transformCodeChallenge(String codeChallenge) {
  return const Base64Encoder()
      .convert(sha256.convert(ascii.encode(codeChallenge)).bytes)
      .replaceAll("/", '')
      .replaceAll("+", '')
      .replaceAll("=", '');
}
