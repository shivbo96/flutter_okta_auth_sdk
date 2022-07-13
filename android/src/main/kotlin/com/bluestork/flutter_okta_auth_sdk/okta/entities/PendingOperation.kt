package com.bluestork.flutter_okta_auth_sdk.okta.entities

import io.flutter.plugin.common.MethodChannel

object PendingOperation {
    var hasPendingOperation: Boolean = false
    var method: String? = null
    var result: MethodChannel.Result? = null

    fun init(method: String, result: MethodChannel.Result) {
        if (hasPendingOperation) {
            throw IllegalStateException(
                    "Concurrent operations detected: " + PendingOperation.method + ", " + method)
        }
        hasPendingOperation = true
        PendingOperation.method = method
        PendingOperation.result = result
    }

    fun success(data: Any? = null) {
        if (!hasPendingOperation) {
            throw IllegalStateException("There is no operation pending")
        }

        hasPendingOperation = false
        method = null
        result!!.success(data)
    }

    fun error(error: Errors, message: String? = null, details: String? = null) {
        if (!hasPendingOperation) {
            throw IllegalStateException("There is no operation pending")
        }

        hasPendingOperation = false
        method = null
        result!!.error(
                error.errorCode,
                message ?: error.errorMessage,
                details)
    }
}