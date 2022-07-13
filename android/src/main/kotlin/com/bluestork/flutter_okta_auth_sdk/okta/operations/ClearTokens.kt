package com.bluestork.flutter_okta_auth_sdk.okta.operations

import com.bluestork.flutter_okta_auth_sdk.okta.entities.OktaClient
import com.bluestork.flutter_okta_auth_sdk.okta.entities.PendingOperation

fun clearTokens() {
    OktaClient.getWebClient().sessionClient.clear()
    OktaClient.getAuthClient().sessionClient.clear()

    PendingOperation.success(true)
}


