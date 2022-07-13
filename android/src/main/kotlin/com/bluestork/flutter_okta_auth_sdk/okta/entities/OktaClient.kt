package com.bluestork.flutter_okta_auth_sdk.okta.entities

import com.okta.oidc.OIDCConfig
import com.okta.oidc.clients.AuthClient
import com.okta.oidc.clients.web.WebAuthClient

object OktaClient {
    var isInitilized: Boolean = false
    private var config: OIDCConfig? = null
    private var webClient: WebAuthClient? = null
    private var authClient: AuthClient? = null

    fun init(config: OIDCConfig, webClient: WebAuthClient, authClient: AuthClient) {
        OktaClient.config = config
        OktaClient.webClient = webClient
        OktaClient.authClient = authClient
        isInitilized = true
    }

    fun getConfig(): OIDCConfig {
        if (!isInitilized) {
            throw IllegalStateException(Errors.NOT_CONFIGURED.errorMessage)
        }
        return config!!
    }

    fun getWebClient(): WebAuthClient {
        if (!isInitilized) {
            throw IllegalStateException(Errors.NOT_CONFIGURED.errorMessage)
        }
        return webClient!!
    }

    fun getAuthClient(): AuthClient {
        if (!isInitilized) {
            throw IllegalStateException(Errors.NOT_CONFIGURED.errorMessage)
        }
        return authClient!!
    }

}