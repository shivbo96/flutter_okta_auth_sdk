package com.bluestork.flutter_okta_auth_sdk.okta.operations

import android.app.Activity
import com.bluestork.flutter_okta_auth_sdk.okta.entities.Constants
import com.bluestork.flutter_okta_auth_sdk.okta.entities.Errors
import com.bluestork.flutter_okta_auth_sdk.okta.entities.OktaClient
import com.bluestork.flutter_okta_auth_sdk.okta.entities.PendingOperation
import com.okta.oidc.AuthorizationStatus
import com.okta.oidc.ResultCallback
import com.okta.oidc.Tokens
import com.okta.oidc.clients.sessions.SessionClient
import com.okta.oidc.util.AuthorizationException


fun signInNew(activity: Activity) {
  registerCallback(activity)
    OktaClient.getWebClient().signIn(activity, null)
}

