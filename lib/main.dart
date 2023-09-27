import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pioneer_doctor/view/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseOptions options = defaultTargetPlatform == TargetPlatform.iOS
      ? const FirebaseOptions(
          apiKey: 'AIzaSyBb3qijWnU4Ka5ZiFiXw_kHH3ibaRy7Mxc',
          appId: '1:520181459755:ios:4a4fd7a0683e95f27df36e',
          messagingSenderId: '520181459755',
          projectId: 'dentist-system-cbc47',
          storageBucket: 'dentist-system-cbc47.appspot.com',
          iosClientId: '520181459755-416phsnprtt5k09hl68bnmppoh5r5hth.apps.googleusercontent.com',
          iosBundleId: 'com.example.pioneerDoctor',
        )
      : const FirebaseOptions(
          apiKey: "AIzaSyAetq0h2Pih_E0UqHO53zb9xjT5pPAOfZk",
          authDomain: "dentist-system-cbc47.firebaseapp.com",
          projectId: "dentist-system-cbc47",
          storageBucket: "dentist-system-cbc47.appspot.com",
          messagingSenderId: "520181459755",
          appId: "1:520181459755:web:70cf3e69d779cc4d7df36e",
          measurementId: "G-B0MMKBHYV9");

  await Firebase.initializeApp(
    options: options,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
  ));
}
