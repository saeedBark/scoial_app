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
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel userModel;
  void getUser() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      userModel = UserModel.formjson(value.data());
      print(userModel.name);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
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
    const BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined), label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.chat_outlined), label: 'Chat'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.post_add_outlined), label: 'Post'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.supervised_user_circle_sharp), label: 'Users'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings_outlined), label: 'Setting'),
  ];

  void changeBottom(int index) {
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomState());
    }
  }

  ///////////// image picker //////////
  File profileImage;
  var picker = ImagePicker();
  Future<void> getImage() async {
    final pickerFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickerFile != null) {
      profileImage = File(pickerFile.path);
      print(pickerFile.path);
      //IMG_20230317_222754.jpg
      emit(SocialProfileImagePickerSuccessState());
    } else {
      print('No Image selected.');
      emit(SocialProfileImagePickerErrorState());
    }
  }

  File coverImage;
  Future<void> getCover() async {
    final pickerFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickerFile != null) {
      coverImage = File(pickerFile.path);
      emit(SocialCoverImagePickerSuccessState());
    } else {
      print('No Cover selected.');
      emit(SocialCoverImagePickerErrorState());
    }
  }

  /////////
  String profileImageUrl = '';
  void uploadProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        profileImageUrl = value;
        emit(SocialUploadProfileImageSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadProfileImageErrorState());
    });
  }

  String coverImageUrl = '';
  void uploadCoverImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        coverImageUrl = value;
        emit(SocialUploadCoverImageSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUserImages({
    String name,
    String phone,
    String bio,
  }) {
    emit(SocialUdateUserLoadingState());
    if (coverImage != null) {
      uploadCoverImage();
    } else if (profileImage != null) {
      uploadProfileImage();
    } else {
      updateUser(
        name: name,
        phone: phone,
        bio: bio,
      );
    }
  }

  void updateUser({
    String name,
    String phone,
    String bio,
  }) {
    UserModel model = UserModel(
        name: name,
        phone: phone,
        bio: bio,
        uid: userModel.uid,
        email: userModel.email,
        image: userModel.image,
        cover: userModel.cover,
        isEmailVerified: false);

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uid)
        .update(model.toMap())
        .then((value) {
      getUser();
    }).catchError((error) {
      emit(SocialUdateUserErrorState());
    });
  }
}
