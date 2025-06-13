import 'dart:async';

import 'dart:html' as html show window;

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// A web implementation of the FlutterOktaAuthSdk plugin.
class FlutterOktaAuthSdkWeb {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel('flutter_okta_auth_sdk', const StandardMethodCodec(), registrar);

    final pluginInstance = FlutterOktaAuthSdkWeb();
    channel.setMethodCallHandler(pluginInstance.handleMethodCall);
  }

  /// Handles method calls over the MethodChannel of this plugin.
  /// Note: Check the "federated" architecture for a new way of doing this:
  /// https://flutter.dev/go/federated-plugins
  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'getPlatformVersion':
        return getPlatformVersion();
      default:
        throw PlatformException(code: 'Unimplemented', details: 'flutter_okta_auth_sdk for web doesn\'t implement \'${call.method}\'');
    }
  }

  /// Returns a [String] containing the version of the platform.
  Future<String> getPlatformVersion() {
    final version = html.window.navigator.userAgent;
    return Future.value(version);
  }
}
