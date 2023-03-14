import 'package:flutter/material.dart';
import 'dart:convert';

import 'services/okta_auth_provider.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/main';

  const MainScreen({Key? key}) : super(key: key);

  parseUser(Map<String, dynamic> json) {
    return json['name'] as String;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Methods"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  var userJson =
                      await OktaAuthProvider.of(context)?.authService.getUser();
                  debugPrint(userJson);
                  Map<String, dynamic> user = jsonDecode(userJson);
                  debugPrint(user.toString());
                },
                child: const Text('getUser', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  await OktaAuthProvider.of(context)?.authService.logout();
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                child: const Text('Logout', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  var isAuthenticated = await OktaAuthProvider.of(context)
                      ?.authService
                      .isAuthenticated();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(isAuthenticated ?? false
                        ? 'you are authenticated by okta'
                        : 'you are not authenticated by okta'),
                    duration: const Duration(seconds: 2),
                  ));
                },
                child: const Text('isAuthenticated',
                    style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  var accessToken = await OktaAuthProvider.of(context)
                      ?.authService
                      .getAccessToken();

                  debugPrint("Access Token ==> ${accessToken.toString()} ");

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text('your access token is ${accessToken.toString()}'),
                    duration: const Duration(seconds: 2),
                  ));
                },
                child: const Text('getAccessToken',
                    style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  var idToken = await OktaAuthProvider.of(context)
                      ?.authService
                      .getIdToken();

                  debugPrint("ID Token ==> ${idToken.toString()} ");
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('your id token is ${idToken.toString()}'),
                    duration: const Duration(seconds: 2),
                  ));
                },
                child: const Text('getIdToken', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  var result = await OktaAuthProvider.of(context)
                      ?.authService
                      .revokeAccessToken();

                  debugPrint("result ==> ${result.toString()} ");

                  Navigator.of(context).pushReplacementNamed('/main');
                },
                child: const Text('revokeAccessToken',
                    style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  var result = await OktaAuthProvider.of(context)
                      ?.authService
                      .revokeIdToken();
                  debugPrint("result ==> ${result.toString()} ");
                  Navigator.of(context).pushReplacementNamed('/splash');
                },
                child:
                    const Text('revokeIdToken', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  var result = await OktaAuthProvider.of(context)
                      ?.authService
                      .revokeRefreshToken();
                  debugPrint("result ==> ${result.toString()} ");
                  Navigator.of(context).pushReplacementNamed('/splash');
                },
                child: const Text('revokeRefreshToken',
                    style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  var result = await OktaAuthProvider.of(context)
                      ?.authService
                      .clearTokens();
                  debugPrint("result ==> ${result.toString()} ");
                  Navigator.of(context).pushReplacementNamed('/splash');
                },
                child:
                    const Text('clearTokens', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  var result = await OktaAuthProvider.of(context)
                      ?.authService
                      .introspectAccessToken();

                  debugPrint("introspectAccessToken ==> ${result.toString()} ");
                },
                child: const Text('introspectAccessToken',
                    style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  var result = await OktaAuthProvider.of(context)
                      ?.authService
                      .introspectIdToken();
                  debugPrint("introspectIdToken ==> ${result.toString()} ");
                },
                child: const Text('introspectIdToken',
                    style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  var result = await OktaAuthProvider.of(context)
                      ?.authService
                      .introspectRefreshToken();
                  debugPrint(
                      "introspectRefreshToken ==> ${result.toString()} ");
                },
                child: const Text('introspectRefreshToken',
                    style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  var result = await OktaAuthProvider.of(context)
                      ?.authService
                      .refreshTokens();
                  debugPrint("refreshTokens ==> ${result.toString()} ");
                },
                child:
                    const Text('refreshTokens', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
