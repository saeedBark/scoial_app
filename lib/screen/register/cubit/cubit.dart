import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/model/user_model.dart';
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
      bio: 'write a comment.....',
      cover: 'https://static.freeimages.com/images/home/filetypes/photo.png',
      image: 'data:image/jpeg;base64,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',
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
