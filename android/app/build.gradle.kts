import java.util.Properties


plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val local = Properties().apply {
    val lp = rootProject.file("key.properties")

    if (lp.exists())
{
    load(lp.reader(Charsets.UTF_8))
}
}

val keyP = Properties().apply {
    val kp = file("key.properties")
    if (kp.exists()){
        load(kp.inputStream())
    }
}


val flutterVersionCode =  1
val flutterVersionName = "1.0.1"


android {
    namespace = "com.ulin.mitrajaya"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.ulin.mitrajaya"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutterVersionCode
        versionName = flutterVersionName
    }

    signingConfigs {
        create("release") {
            keyAlias = keyP["keyAlias"]?.toString()
            keyPassword = keyP["keyPassword"]?.toString()
            storeFile = keyP["storeFile"]?.let { file(it) }
            storePassword = keyP["storePassword"]?.toString()
        }
    }

    buildTypes {
        // getBytName("release") {
        //     signingConfig = signingConfigs.getByName("release")
        // }
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            // signingConfig = signingConfigs.getByName("debug")
signingConfig = signingConfigs.getByName("release")
        }
    }

    dependencies {
        coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    }
}

flutter {
    source = "../.."
}
