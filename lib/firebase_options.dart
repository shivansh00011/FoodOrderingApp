// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCglWdq_fubVyEByjV8wOEoFQJeXo2WLRs',
    appId: '1:690504732982:web:1188d65f0d07f2ec156397',
    messagingSenderId: '690504732982',
    projectId: 'fooddeliveryapp-97e0f',
    authDomain: 'fooddeliveryapp-97e0f.firebaseapp.com',
    storageBucket: 'fooddeliveryapp-97e0f.appspot.com',
    measurementId: 'G-X4CRP8T0BV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDgTos_-um6-wMEta8Wy36Jaq_UZG6LMCs',
    appId: '1:690504732982:android:7b2375c7a7d6bd58156397',
    messagingSenderId: '690504732982',
    projectId: 'fooddeliveryapp-97e0f',
    storageBucket: 'fooddeliveryapp-97e0f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA1qt0IHKRoq7SFEXLn661ht1pusB_Pd6g',
    appId: '1:690504732982:ios:8c11892ae627f3f3156397',
    messagingSenderId: '690504732982',
    projectId: 'fooddeliveryapp-97e0f',
    storageBucket: 'fooddeliveryapp-97e0f.appspot.com',
    iosBundleId: 'com.example.zotato',
  );
}
