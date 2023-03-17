import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/componets/componets.dart';
import 'package:social_app/layout/cubit/state.dart';
import 'package:social_app/model/usreRegister_model.dart';
import 'package:social_app/screen/chat/chat_screen.dart';
import 'package:social_app/screen/feed/feed_screen.dart';
import 'package:social_app/screen/post/newPost_screen.dart';
import 'package:social_app/screen/setting/setting_screen.dart';
import 'package:social_app/screen/users/users_screen.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel userModel;
  void getUser() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
          print(value.data());
          userModel = UserModel.formjson(value.data());
          print(userModel.name);
          emit(SocialGetUserSuccessState());
    })
        .catchError((error) {
          print(error.toString());
          emit(SocialGetUserErrorState());
    });
  }

  var currentIndex = 0;
   List<Widget> screen = [
     FeedScreen(),
     ChatScreen(),
     NewPostScreen(),
     UsersScreen(),
     SettingScreen(),
   ];
   List<String> title = [
     'Home',
     'Chat',
     'Post',
     'User',
     'Setting',
   ];
   List<BottomNavigationBarItem> bottomNavgatebar = [
     const BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: 'Home'),
     const BottomNavigationBarItem(icon: Icon(Icons.chat_outlined),label: 'Chat'),
     const BottomNavigationBarItem(icon: Icon(Icons.post_add_outlined),label: 'Post'),
     const BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle_sharp),label: 'Users'),
     const BottomNavigationBarItem(icon: Icon(Icons.settings_outlined),label: 'Setting'),
   ];

   void changeBottom(int index){

     if(index == 2) {
       emit(SocialNewPostState());
     }
     else {
       currentIndex = index;
       emit(SocialChangeBottomState());
     }
   }
   /////////////
  File profileImage;
  var picker = ImagePicker();
  Future<void> getImage() async {
    final pickerFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickerFile != null) {
      profileImage = File(pickerFile.path);
      emit(SocialProfileImagePickerSuccessState());
    }else{
      print('No image selected.');
      emit(SocialProfileImagePickerErrorState());
    }
  }
}
