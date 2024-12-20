// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDobRLfjpVUG66ArW3sHnUHG0e3kPEeKt0',
    appId: '1:166901344142:web:c2dcd0698cbef680cbe6df',
    messagingSenderId: '166901344142',
    projectId: 'mobile-final-e3f50',
    authDomain: 'mobile-final-e3f50.firebaseapp.com',
    storageBucket: 'mobile-final-e3f50.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBpq7HhjQlYD8IHFOBzPJkHA_0NLxdCxWE',
    appId: '1:166901344142:android:2c193cdc8838e04bcbe6df',
    messagingSenderId: '166901344142',
    projectId: 'mobile-final-e3f50',
    storageBucket: 'mobile-final-e3f50.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAL3Bq08YWxueZ7MUKktxIf8eOW9m4ybP4',
    appId: '1:166901344142:ios:20bf54c409efb83bcbe6df',
    messagingSenderId: '166901344142',
    projectId: 'mobile-final-e3f50',
    storageBucket: 'mobile-final-e3f50.firebasestorage.app',
    iosBundleId: 'com.example.driva',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAL3Bq08YWxueZ7MUKktxIf8eOW9m4ybP4',
    appId: '1:166901344142:ios:20bf54c409efb83bcbe6df',
    messagingSenderId: '166901344142',
    projectId: 'mobile-final-e3f50',
    storageBucket: 'mobile-final-e3f50.firebasestorage.app',
    iosBundleId: 'com.example.driva',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDobRLfjpVUG66ArW3sHnUHG0e3kPEeKt0',
    appId: '1:166901344142:web:4997b6ff43b8ae20cbe6df',
    messagingSenderId: '166901344142',
    projectId: 'mobile-final-e3f50',
    authDomain: 'mobile-final-e3f50.firebaseapp.com',
    storageBucket: 'mobile-final-e3f50.firebasestorage.app',
  );
}
