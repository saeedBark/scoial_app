import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/model/usreRegister_model.dart';
import 'package:social_app/screen/register/cubit/state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changPasswordShow() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(RegisterChangePasswordShowState());
  }

  void userRegister({
    String email,
    String password,
    String phone,
    String name,
  }) {
    print('a');
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      // print(value.user.email);
      // print(value.user.uid);
      createUser(
        name: name,
        email: email,
        phone: phone,
        uid: value.user.uid,

      );


    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  void createUser({
    String email,
    String phone,
    String name,
    String uid,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uid: uid,
      isEmailVerified: false
    );

    emit(RegisterCreateUserState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(RegisterCreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterCreateUserErrorState());
    });
  }
}
