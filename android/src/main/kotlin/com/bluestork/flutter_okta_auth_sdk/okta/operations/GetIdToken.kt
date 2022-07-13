package com.bluestork.flutter_okta_auth_sdk.okta.operations

import com.bluestork.flutter_okta_auth_sdk.okta.entities.Errors
import com.bluestork.flutter_okta_auth_sdk.okta.entities.OktaClient
import com.bluestork.flutter_okta_auth_sdk.okta.entities.PendingOperation

fun getIdToken() {

    var sessionClient = OktaClient.getWebClient().sessionClient
    var tokens = sessionClient.tokens

    if (tokens.idToken == null) {
        PendingOperation.error(Errors.NO_ID_TOKEN)
    } else {
        PendingOperation.success(tokens.idToken)
    }
}
