package com.bluestork.flutter_okta_auth_sdk.okta.operations

import android.app.Activity
import com.bluestork.flutter_okta_auth_sdk.okta.entities.OktaClient


fun signInNew(activity: Activity) {
  registerCallback(activity)
    OktaClient.getWebClient().signIn(activity, null)
}

