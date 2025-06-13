# 1. Preserve generic signatures (needed for Gson’s TypeToken<T> to work)
-keepattributes Signature

# 2. Keep Gson’s TypeToken and any subclasses so generic parameters aren’t stripped
-keep,allowobfuscation class com.google.gson.reflect.TypeToken
-keep,allowobfuscation class * extends com.google.gson.reflect.TypeToken

# 3. Preserve Gson annotations at runtime
-keepattributes RuntimeVisibleAnnotations,AnnotationDefault

# 4. Keep fields annotated with @SerializedName
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# 5. Keep classes annotated with @JsonAdapter
-keep,allowobfuscation,allowoptimization @com.google.gson.annotations.JsonAdapter class *

# 6. Keep no-args constructors for Gson adapters/serializers/deserializers
-keepclassmembers class * extends com.google.gson.TypeAdapter {
    <init>();
}
-keepclassmembers class * implements com.google.gson.TypeAdapterFactory {
    <init>();
}
-keepclassmembers class * implements com.google.gson.JsonSerializer {
    <init>();
}
-keepclassmembers class * implements com.google.gson.JsonDeserializer {
    <init>();
}

# 7. Keep your app’s model classes that Gson will (de)serialize
-keep class com.myapplication.model.api.** { *; }
-keep class com.atech.core.model.** { *; }
-keep class com.atech.core.utils.JsonKt { *; }

# 8. Keep Adapty SDK (and suppress its UI warnings)
-keep class com.adapty.** { *; }
-dontwarn com.adapty.ui.**
-keep class com.okta.** { *; }
