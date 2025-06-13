import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_okta_auth/services/auth_okta_service.dart';
import 'package:flutter_okta_auth_sdk/base_request.dart';

import 'landing_screen.dart';
import 'services/okta_auth_provider.dart';
import 'dart:html' as html;

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    html.window.onMessage.listen((event) {
      final token = event.data.toString();
      if (token.isNotEmpty) {
        debugPrint("Received token from JS: $token");
        // Navigator.of(context).pushNamed(LandingScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome"), centerTitle: true),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            if (kIsWeb) {
              // var codeVerifier = getRandomString(50);
              // js.context.callMethod(
              //     'loginOkta', [transformCodeChallenge(codeVerifier)]);
              var codeVerifier = getRandomString(50);
              var codeChallenge = transformCodeChallenge(codeVerifier);
              var config = AuthOktaService.oktaBaseRequest;
              callLoginWithOktaWeb(config, codeChallenge);
            } else {
              var isAuthenticated = await OktaAuthProvider.of(context)?.authService.isAuthenticated();
              if (isAuthenticated == true) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('you are authenticated by okta'), duration: Duration(seconds: 2)));
                Navigator.of(context).pushNamed(LandingScreen.routeName);
              } else {
                var isAuthenticated = await OktaAuthProvider.of(context)?.authService.flutterOktaAuthSdk.signIn();
                debugPrint("Token Type: $isAuthenticated");
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('you are not authenticated by okta'), duration: Duration(seconds: 2)));
              }
            }
          },
          child: const Text('Log In'),
        ),
      ),
    );
  }

  Future<void> callLoginWithOktaWeb(BaseRequest request, String codeChallenge) async {
    final config = convertBaseRequestToMap(request);
    config['codeChallenge'] = codeChallenge;

    await OktaAuthProvider.of(context)?.authService.webSignIn(config);
  }
}

final _rnd = Random();
const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890_';

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

String transformCodeChallenge(String codeChallenge) {
  return const Base64Encoder().convert(sha256.convert(ascii.encode(codeChallenge)).bytes).replaceAll("/", '').replaceAll("+", '').replaceAll("=", '');
}
