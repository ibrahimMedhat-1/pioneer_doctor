// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_dart/core.dart';

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
    apiKey: 'AIzaSyAetq0h2Pih_E0UqHO53zb9xjT5pPAOfZk',
    appId: '1:520181459755:web:70cf3e69d779cc4d7df36e',
    messagingSenderId: '520181459755',
    projectId: 'dentist-system-cbc47',
    authDomain: 'dentist-system-cbc47.firebaseapp.com',
    storageBucket: 'dentist-system-cbc47.appspot.com',
    measurementId: 'G-B0MMKBHYV9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDxZDR_PXBd25Pomk-yhdnPY7Lm16dFWPY',
    appId: '1:520181459755:android:5e6b25157c9836de7df36e',
    messagingSenderId: '520181459755',
    projectId: 'dentist-system-cbc47',
    storageBucket: 'dentist-system-cbc47.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBb3qijWnU4Ka5ZiFiXw_kHH3ibaRy7Mxc',
    appId: '1:520181459755:ios:4a4fd7a0683e95f27df36e',
    messagingSenderId: '520181459755',
    projectId: 'dentist-system-cbc47',
    storageBucket: 'dentist-system-cbc47.appspot.com',
    iosClientId: '520181459755-416phsnprtt5k09hl68bnmppoh5r5hth.apps.googleusercontent.com',
    iosBundleId: 'com.example.pioneerDoctor',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBb3qijWnU4Ka5ZiFiXw_kHH3ibaRy7Mxc',
    appId: '1:520181459755:ios:da2280a1a72a62ee7df36e',
    messagingSenderId: '520181459755',
    projectId: 'dentist-system-cbc47',
    storageBucket: 'dentist-system-cbc47.appspot.com',
    iosClientId: '520181459755-fhtrrno7esad74rq1bfmrj3csrg3e83j.apps.googleusercontent.com',
    iosBundleId: 'com.example.pioneerDoctor.RunnerTests',
  );
}
