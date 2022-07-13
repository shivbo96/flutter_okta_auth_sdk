package com.bluestork.flutter_okta_auth_sdk.okta.operations

import com.bluestork.flutter_okta_auth_sdk.okta.entities.OktaClient
import com.bluestork.flutter_okta_auth_sdk.okta.entities.PendingOperation

fun isAuthenticated() {
    val sessionClient = OktaClient.getWebClient().sessionClient
    PendingOperation.success(sessionClient.isAuthenticated)
}


