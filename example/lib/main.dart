import 'package:flutter/material.dart';
import 'package:flutter_okta_auth_sdk/base_request.dart';
import 'landing_screen.dart';
import 'login_screen.dart';
import 'main_screen.dart';
import 'services/auth_okta_service.dart';
import 'services/okta_auth_provider.dart';
import 'splash_screen.dart';
import 'config/configure_nonweb.dart' if (dart.library.html) 'config/configure_web.dart';

import 'dart:js' as js;
import 'dart:html';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OktaAuthProvider(
      authService: AuthOktaService(),
      child: MaterialApp(
        initialRoute: LoginScreen.routeName,
        onGenerateRoute: (setting) {
          debugPrint("setting name is ${setting.name}");
          if (setting.name!.contains("callback?code=")) {
            var request = AuthOktaService.oktaBaseRequest;

            final config = convertBaseRequestToMap(request);
            config['codeValue'] = window.location.href.split("=")[1].split('&')[0];

            js.context.callMethod('loginTokenOkta', [config]);
            window.addEventListener("message", (event) {
              MessageEvent accessToken = event as MessageEvent;
              if (accessToken.data != null && accessToken.data != "") {
                debugPrint("token is ${accessToken.data}");
              }
            });
            return null;
          }
          return null;
        },
        theme: ThemeData(primarySwatch: Colors.blue),
        // home: const LoginScreen(),
        routes: {
          SplashScreen.routeName: (ctx) => const SplashScreen(),
          MainScreen.routeName: (ctx) => const MainScreen(),
          LoginScreen.routeName: (ctx) => const LoginScreen(),
          LandingScreen.routeName: (ctx) => const LandingScreen(),
        },
      ),
    );
  }
}
