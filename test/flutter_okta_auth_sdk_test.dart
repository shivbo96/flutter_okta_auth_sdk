import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_okta_auth_sdk/flutter_okta_auth_sdk.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_okta_auth_sdk');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterOktaAuthSdk.platformVersion, '42');
  });
}
