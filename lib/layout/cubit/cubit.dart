import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/componets/componets.dart';
import 'package:social_app/layout/cubit/state.dart';
import 'package:social_app/model/message_model.dart';
import 'package:social_app/model/post_model.dart';
import 'package:social_app/model/user_model.dart';
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
    if (index == 1) {
      getAllUsers();
    }
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
  // String profileImageUrl = '';
  void uploadProfileImage({
    @required String name,
    @required String phone,
    @required String bio,
  }) {
    emit(SocialUdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        // profileImageUrl = value;
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          profile: value,
        );
        //  emit(SocialUploadProfileImageSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadProfileImageErrorState());
    });
  }

  // String coverImageUrl = '';
  void uploadCoverImage({
    @required String name,
    @required String phone,
    @required String bio,
  }) {
    emit(SocialUdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        //coverImageUrl = value;
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
        //   emit(SocialUploadCoverImageSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadCoverImageErrorState());
    });
  }

  // void updateUserImages({
  //   String name,
  //   String phone,
  //   String bio,
  // }) {
  //   emit(SocialUdateUserLoadingState());
  //   if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   } else {
  //     updateUser(
  //       name: name,
  //       phone: phone,
  //       bio: bio,
  //     );
  //   }
  // }

  void updateUser({
    @required String name,
    @required String phone,
    @required String bio,
    String profile,
    String cover,
  }) {
    UserModel model = UserModel(
        name: name,
        phone: phone,
        bio: bio,
        uid: userModel.uid,
        email: userModel.email,
        image: profile ?? userModel.image,
        cover: cover ?? userModel.cover,
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

///////////Post//////
  File postImage;
  Future<void> getPost() async {
    final pickerFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickerFile != null) {
      postImage = File(pickerFile.path);
      emit(SocialPostImagePickerSuccessState());
    } else {
      print('No Cover selected.');
      emit(SocialPostImagePickerErrorState());
    }
  }

  // void uploadcreateNewPost({
  //   @required String name,
  //   @required String uid,
  //   @required String image,
  //   @required String dateTime,
  //   @required String text,
  // }) {
  //   emit(SocialCreatePostLoadingState());
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('users/${Uri.file(postImage.path).pathSegments.last}')
  //       .putFile(postImage)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       print(value);
  //     }).catchError((error) {
  //       print(error.toString());
  //       emit(SocialCreatePostErrorState());
  //     });
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(SocialCreatePostErrorState());
  //   });
  // }
  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    @required String dateTime,
    @required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
      }).catchError((error) {
        print(error.toString());
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreatePostErrorState());
    });
  }

///////// Create Post /////
  void createPost({
    @required String dateTime,
    @required String text,
    String postImage,
  }) {
    PostModel model = PostModel(
      name: userModel.name,
      uid: userModel.uid,
      image: userModel.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreatePostErrorState());
    });
  }

/////Get Post //////////
  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          print(element.id);
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(
            PostModel.formjson(element.data()),
          );
        }).catchError((error) {});
      });
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetPostsErrorState());
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel.uid)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikesPostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialLikesPostErrorState());
    });
  }

  List<UserModel> users = [];
  void getAllUsers() {
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uid'] != userModel.uid)
            users.add(UserModel.formjson(element.data()));
        });
        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialGetAllUsersErrorState());
      });
    }
  }

  void sendMessage({
    @required String reciveId,
    @required String dateTime,
    @required String text,
  }) {
    MessageModel model = MessageModel(
      senderId: userModel.uid,
      receiverId: reciveId,
      dateTime: dateTime,
      text: text,
    );
    //// set send chats //////
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uid)
        .collection('chats')
        .doc(reciveId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });
    //// set recive chats //////
    FirebaseFirestore.instance
        .collection('users')
        .doc(reciveId)
        .collection('chats')
        .doc(userModel.uid)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });
  }

  List<MessageModel> messages = [];

  void getMessage({
    @required String reciveId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uid)
        .collection('chats')
        .doc(reciveId)
        .collection('messages')
    .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.formjson(element.data()));
      });
      emit(SocialGetMessageSuccessState());
    });
  }
}
