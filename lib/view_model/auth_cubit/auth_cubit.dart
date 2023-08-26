import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pioneer_doctor/core/constants.dart';

import '../../view/home/home.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);
  bool isLoading = false;

  void login({
    context,
    required String email,
    required String password,
  }) {
    isLoading = true;
    emit(ChangeStateToLoading());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
      FirebaseFirestore.instance.collection('login').doc(email).get().then((value) {
        if (value.data()!['type'] == 'founder' || value.data()!['type'] == 'worker') {
          ///["د/ محمد وحيد ", "د/ محمد خالد القاضي", "د/ حسام ابو الحلقان", "د/ لمياء خليفة", "د/ هبة ممدوح"]
          if (value.data()!['type'] == 'founder') {
            isFounder = true;
          }
          drName = value.data()!['name'];
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => const HomeScreen()));
        } else {
          isLoading = false;

          emit(ChangeStateToLoading());
        }
      });
    }).catchError((onError) {
      isLoading = false;
      emit(ChangeStateToLoading());
    });
  }
}
