import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'landing_screen.dart';
import 'login_screen.dart';
import 'main_screen.dart';
import 'services/auth_okta_service.dart';
import 'services/okta_auth_provider.dart';
import 'splash_screen.dart';

// import 'dart:js' as js;
// import 'dart:html';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OktaAuthProvider(
      authService: AuthOktaService(),
      child: MaterialApp(
        initialRoute: LoginScreen.routeName,
        // onGenerateRoute: (setting){
        //   print("setting name is ${setting.name}");
        // if(setting.name!.contains("callback?code=")){
        //   js.context.callMethod('loginTokenOkta',
        //       [window.location.href.split("=")[1].split('&')[0]]);
        //   window.addEventListener("message", (event) {
        //     MessageEvent accessToken = event as MessageEvent;
        //     if (accessToken.data != null && accessToken.data != "") {
        //       print("token is ${accessToken.data}");
        //     }
        //   });
        //   return null;
        // }
        // },
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const LoginScreen(),
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
