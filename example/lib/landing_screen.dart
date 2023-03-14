import 'package:flutter/material.dart';

import 'main_screen.dart';
import 'services/okta_auth_provider.dart';

class LandingScreen extends StatelessWidget {
  static const routeName = '/landing';

  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("You made it!"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                child: const Text('Check Auth Status'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pushNamed(MainScreen.routeName);
                },
                child: const Text('Use API methods'),
              ),
            ],
          ),
        ));
  }
}
