package com.bluestork.flutter_okta_auth_sdk.okta.entities

enum class AvailableMethods(val methodName: String) {
    CREATE_CONFIG("createConfig"),
    SIGN_IN("signIn"),
    SIGN_OUT("signOut"),
    AUTHENTICATE("authenticate"),
    GET_ACCESS_TOKEN("getAccessToken"),
    GET_ID_TOKEN("getIdToken"),
    GET_USER("getUser"),
    IS_AUTHENTICATED("isAuthenticated"),
    REVOKE_ACCESS_TOKEN("revokeAccessToken"),
    REVOKE_ID_TOKEN("revokeIdToken"),
    REVOKE_REFRESH_TOKEN("revokeRefreshToken"),
    INTROSPECT_ACCESS_TOKEN("introspectAccessToken"),
    INTROSPECT_ID_TOKEN("introspectIdToken"),
    INTROSPECT_REFRESH_TOKEN("introspectRefreshToken"),
    REFRESH_TOKENS("refreshTokens"),
    CLEAR_TOKENS("clearTokens"),
    IS_ACCESS_TOKEN_EXPIRED("isAccessTokenExpired"),
}

inline fun <reified T : Enum<T>> enumContains(name: String): Boolean {
    return enumValues<T>().any { it.name == name }
}