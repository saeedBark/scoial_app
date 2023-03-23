import 'package:flutter/material.dart';
import 'package:social_app/componets/componets.dart';
import 'package:social_app/remote/sharedPreference/shared_preference.dart';
import 'package:social_app/screen/login/login_screen.dart';

class UsersScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: (){
      SharedPreferenceCach.logout(key: 'uId').then((value) {
        navigatorAndReplace(context, LoginScreen());
      });
    },child: const Icon(Icons.add),);
  }
}
