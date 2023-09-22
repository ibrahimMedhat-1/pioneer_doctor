import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pioneer_doctor/view/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyAetq0h2Pih_E0UqHO53zb9xjT5pPAOfZk",
        authDomain: "dentist-system-cbc47.firebaseapp.com",
        projectId: "dentist-system-cbc47",
        storageBucket: "dentist-system-cbc47.appspot.com",
        messagingSenderId: "520181459755",
        appId: "1:520181459755:web:70cf3e69d779cc4d7df36e",
        measurementId: "G-B0MMKBHYV9"),
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
  ));
}
