[![Pub](https://img.shields.io/pub/v/flutter_okta_auth_sdk.svg)](https://pub.dartlang.org/packages/flutter_okta_auth_sdk)

# flutter_okta_auth_sdk


The Flutter Okta Auth SDK library helps you to add authentication in your Flutter apps. It is a wrapper around [Okta Android](https://github.com/okta/okta-oidc-android) and [Okta iOS](https://github.com/okta/okta-oidc-ios).

Created by Shivam Mishra [@shivbo96](https://github.com/shivbo96)

<a href="https://www.buymeacoffee.com/smishra" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>

This library follows the current best practice for native apps using:

* [OAuth 2.0 Authorization Code Flow](https://tools.ietf.org/html/rfc6749#section-1.3.1)
* [Proof Key for Code Exchange (PKCE)](https://tools.ietf.org/html/rfc763)

This library also exposes APIs to interact with [Authentication API](https://developer.okta.com/docs/api/resources/authn) directly to implement native UI for authentication.

## Sample

You can check how to use this plugin in this sample refer to `example/lib/main.dart`

## Todos

This library is under construction. These are the next steps:

### Android

~~createConfig~~
~~signIn~~
customSignIn
~~signOut~~
authenticate
~~isAuthenticated~~
~~getAccessToken~~
~~getIdToken~~
~~getUser~~
~~revokeAccessToken~~
~~revokeIdToken~~
~~revokeRefreshToken~~
~~clearTokens~~
~~introspectAccessToken~~
~~introspectIdToken~~
~~introspectRefreshToken~~
~~refreshTokens~~

### iOS

~~setup~~
~~signIn~~
customSignIn
~~signOut~~
getAuthClient
authenticate
~~isAuthenticated~~
~~getAccessToken~~
~~getIdToken~~
~~getUser~~
getUserFromIdToken
~~revokeAccessToken~~
~~revokeIdToken~~
~~revokeRefreshToken~~
~~clearTokens~~
~~introspectAccessToken~~
~~introspectIdToken~~
~~introspectRefreshToken~~
~~refreshTokens~~

### web

setup
signIn
customSignIn
singOut
getAuthClient
authenticate
isAuthenticated
getAccessToken
getIdToken
getUser
getUserFromIdToken
revokeAccessToken
revokeIdToken
revokeRefreshToken
clearTokens
introspectAccessToken
introspectIdToken
introspectRefreshToken
refreshTokens

## Prerequisites

* If you do not already have a **Developer Edition Account**, you can create one at [https://developer.okta.com/signup/](https://developer.okta.com/signup/).

## Add an OpenID Connect Client in Okta

In Okta, applications are OpenID Connect clients that can use Okta Authorization servers to authenticate users.
Your Okta Org already has a default authorization server, so you just need to create an OIDC client that will use it.

* Log into the Okta Developer Dashboard, click **Applications** then **Add Application**.
* Choose **Native** as the platform, then submit the form the default values, which should look similar to this:

| Setting             | Value                                        |
| ------------------- | -------------------------------------------- |
| App Name            | My Native App                                |
| Login redirect URIs | com.mynativeapp:/                            |
| Grant Types Allowed | Authorization Code, Refresh Token            |

After you have created the application there are two more values you will need to gather:

| Setting       | Where to Find                                                                  |
| ------------- | ------------------------------------------------------------------------------ |
| Client ID     | In the applications list, or on the "General" tab of a specific application.   |
| Org URL       | On the home screen of the developer dashboard, in the upper right.             |

**Note:** *As with any Okta application, make sure you assign Users or Groups to the OpenID Connect Client. Otherwise, no one can use it.*

These values will be used in your Flutter application to setup the OpenID Connect flow with Okta.

## Getting started

You can check the pub.dev to know how to install this plugin. [Flutter Okta Auth SDK](https://pub.dev/packages/flutter_okta_auth_sdk/install).

### Setup Android

For Android, there is one steps that you must take:

1. [Add a redirect scheme to your project.](#add-redirect-scheme)

#### Add redirect scheme

1. Defining a redirect scheme to capture the authorization redirect. In `android/app/build.gradle`, under `android` -> `defaultConfig`, add:

```
  manifestPlaceholders = [
    appAuthRedirectScheme: 'com.sampleapplication'
  ]
```

2. Make sure your `minSdkVersion` is `19`.
3. Create a proguard-rules.pro file inside the android/app folder and add the following rule

```
-ignorewarnings
-keep class com.okta.oidc.** { *; }

```
4. Add a couple of rules to the buildTypes/release block inside the app/build.gradle file

   buildTypes {
   release {
   useProguard true
   proguardFiles getDefaultProguardFile('proguard-android.txt'),
   'proguard-rules.pro'
   signingConfig signingConfigs.release
   }
   }


### Setup iOS

**TODO: (Need to do the iOS bridge)**

## Usage

You will need the values from the OIDC client that you created in the previous step to set up.
You will also need to know your Okta Org URL, which you can see on the home page of the Okta Developer console.

Before calling any other method, it is important that you call `createConfig` to set up the configuration properly on the native modules.

``` dart
import 'package:flutter_okta_auth_sdk/flutter_okta_auth_sdk.dart';
import 'package:flutter_okta_auth_sdk/base_request.dart';

 var flutterOktaAuthSdk = FlutterOktaAuthSdk();
var oktaBaseRequest = BaseRequest(
      issuer: OKTA_ISSUER_URL,
      clientId: OKTA_CLIENT_ID,
      discoveryUrl: OKTA_DISCOVERY_URL,
      endSessionRedirectUri: OKTA_LOGOUT_REDIRECT_URI,
      redirectUrl: OKTA_REDIRECT_URI,
      scopes: ['openid', 'profile', 'email', 'offline_access']);

await flutterOktaAuthSdk.createConfig(oktaBaseRequest);
```

### `createConfig`

This method will create a configured client on the native modules.

**Note**: `requireHardwareBackedKeyStore` is a configurable setting only on android devices.
If you're a developer testing on android emulators, set this field to `false`.

### `signIn`

This method will redirect to okta´s sign in page, and will return when to the app if the user cancels the request or has error or the login was made.
The return object will have a parameter `resolve_type` that can assume the following values: `authorized`, `signed_out`, `cancelled`

``` dart
if (flutterOktaAuthSdk.isInitialized == false) {
  await this.createConfig();
}
var result = await flutterOktaAuthSdk.signIn();
```

### `signOut`

Clear the browser session and clear the app session (stored tokens) in memory. Fires an event once a user successfully logs out
The return object will have a parameter `resolve_type` that can assume the following values: `authorized`, `signed_out`, `cancelled`

``` dart
  if (flutterOktaAuthSdk.isInitialized == false) {
    await this.createConfig();
  }
  var result = await flutterOktaAuthSdk.signOut();
```

### `isAuthenticated`

Return `true` if there is a valid access token or ID token. Otherwise `false`

### `getAccessToken`

This method returns the access token as a string. If no access token is available (either does not exist, or expired), an error will be thrown.

### `getIdToken`

This method returns the identity token as a string. If no identity token is available an error will be thrown.

### `getUser`

Returns the most up-to-date user claims from the [OpenID Connect `/userinfo`](https://developer.okta.com/docs/api/resources/oidc#userinfo) endpoint.

### `revokeAccessToken`

Revoke the access token to make it inactive. Resolves `true` if access token has been successfully revoked.

### `revokeIdToken`

Revoke the identity token to make it inactive. Resolves `true` if id token has been successfully revoked.

### `revokeRefreshToken`

Revoke the refresh token to make it inactive. Resolves `true` if refresh token has been successfully revoked.

### `clearTokens`

Removes all tokens from local storage. Resolves `true` if tokens were successfully cleared.

### `introspectAccessToken`

Introspect the access token.

Sample responses can be found [here](https://developer.okta.com/docs/reference/api/oidc/#response-properties-3)

### `introspectIdToken`

Introspect the id token.

Sample responses can be found [here](https://developer.okta.com/docs/reference/api/oidc/#response-properties-3)

### `introspectRefreshToken`

Introspect the refresh token.

Sample responses can be found [here](https://developer.okta.com/docs/reference/api/oidc/#response-properties-3)

### `refreshTokens`
Refreshes all tokens. Return the refreshed tokens.




