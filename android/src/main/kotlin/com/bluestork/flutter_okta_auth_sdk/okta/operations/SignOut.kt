package com.bluestork.flutter_okta_auth_sdk.okta.operations

import android.app.Activity
import com.bluestork.flutter_okta_auth_sdk.okta.entities.OktaClient

fun signOut(activity: Activity) {
    registerCallback(activity)
    OktaClient.getWebClient().signOutOfOkta(activity)
}