import 'package:flutter/material.dart';
import 'package:flutter_okta_auth_sdk/base_request.dart';
import 'package:flutter_okta_auth_sdk/flutter_okta_auth_sdk.dart';

class AuthOktaService {
  var flutterOktaAuthSdk = FlutterOktaAuthSdk();
  static const String oktaDomain = 'trial-7200466-admin.okta.com';
  static const String oktaAuthorizer = 'default';

  static const String oktaClientId = '0oas9qm1r5mB8Jeil697';

  static const String oktaIssuerUrl = 'http://$oktaDomain/oauth2/$oktaAuthorizer';
  static const String oktaDiscoveryUrl = 'http://$oktaDomain/.well-known/openid-configuration';

  static const String oktaRedirectUrl = 'http://localhost:8080/login/callback';
  // static const String oktaRedirectUrl = 'com.bluestork.flutteroktaauth:/callback';
  // static const String oktaLogoutRedirectUrl = 'com.bluestork.flutteroktaauth:/splash';
  static const String oktaLogoutRedirectUrl = 'http://localhost:8080/';

  static final oktaBaseRequest = BaseRequest(
    issuer: oktaIssuerUrl,
    clientId: oktaClientId,
    discoveryUrl: oktaDiscoveryUrl,
    endSessionRedirectUri: oktaLogoutRedirectUrl,
    redirectUrl: oktaRedirectUrl,
    scopes: ["openid", "profile", "offline_access"],
  );

  Future createConfig() async {
    await flutterOktaAuthSdk.createConfig(oktaBaseRequest);
  }

  Future authorize() async {
    try {
      if (flutterOktaAuthSdk.isInitialized == false) {
        await createConfig();
      }
      await flutterOktaAuthSdk.signIn();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future webSignIn(config) async {
    try {
      await flutterOktaAuthSdk.webSignIn(config);
    } catch (e) {
      debugPrint('webSignIn error: $e');
      debugPrint(e.toString());
    }
  }

  Future logout() async {
    try {
      if (flutterOktaAuthSdk.isInitialized == false) {
        await createConfig();
      }
      await flutterOktaAuthSdk.signOut();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future getUser() async {
    try {
      if (flutterOktaAuthSdk.isInitialized == false) {
        await createConfig();
      }
      return await flutterOktaAuthSdk.getUser();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> isAuthenticated() async {
    try {
      if (flutterOktaAuthSdk.isInitialized == false) {
        await createConfig();
      }
      return await flutterOktaAuthSdk.isAuthenticated();
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<String?> getAccessToken() async {
    try {
      if (flutterOktaAuthSdk.isInitialized == false) {
        await createConfig();
      }
      return await flutterOktaAuthSdk.getAccessToken();
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<String?> getIdToken() async {
    try {
      if (flutterOktaAuthSdk.isInitialized == false) {
        await createConfig();
      }
      return await flutterOktaAuthSdk.getIdToken();
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<bool?> revokeAccessToken() async {
    try {
      if (flutterOktaAuthSdk.isInitialized == false) {
        await createConfig();
      }
      return await flutterOktaAuthSdk.revokeAccessToken();
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<bool?> revokeIdToken() async {
    try {
      if (flutterOktaAuthSdk.isInitialized == false) {
        await createConfig();
      }
      return await flutterOktaAuthSdk.revokeIdToken();
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<bool?> revokeRefreshToken() async {
    try {
      if (flutterOktaAuthSdk.isInitialized == false) {
        await createConfig();
      }
      return await flutterOktaAuthSdk.revokeRefreshToken();
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<bool?> clearTokens() async {
    try {
      if (flutterOktaAuthSdk.isInitialized == false) {
        await createConfig();
      }
      return await flutterOktaAuthSdk.clearTokens();
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<String?> introspectAccessToken() async {
    try {
      if (flutterOktaAuthSdk.isInitialized == false) {
        await createConfig();
      }
      return await flutterOktaAuthSdk.introspectAccessToken();
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<String?> introspectIdToken() async {
    try {
      if (flutterOktaAuthSdk.isInitialized == false) {
        await createConfig();
      }
      return await flutterOktaAuthSdk.introspectIdToken();
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<String?> introspectRefreshToken() async {
    try {
      if (flutterOktaAuthSdk.isInitialized == false) {
        await createConfig();
      }
      return await flutterOktaAuthSdk.introspectRefreshToken();
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<String?> refreshTokens() async {
    try {
      if (flutterOktaAuthSdk.isInitialized == false) {
        await createConfig();
      }
      return await flutterOktaAuthSdk.refreshTokens();
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
