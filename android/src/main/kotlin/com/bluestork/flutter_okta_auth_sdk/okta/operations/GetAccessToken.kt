package com.bluestork.flutter_okta_auth_sdk.okta.operations

import com.bluestork.flutter_okta_auth_sdk.okta.entities.Errors
import com.bluestork.flutter_okta_auth_sdk.okta.entities.OktaClient
import com.bluestork.flutter_okta_auth_sdk.okta.entities.PendingOperation

fun getAccessToken() {

    var sessionClient = OktaClient.getWebClient().sessionClient
    var tokens = sessionClient.tokens

    if (tokens.accessToken == null) {
        PendingOperation.error(Errors.NO_ACCESS_TOKEN)
    } else {
        PendingOperation.success(tokens.accessToken)
    }
}
