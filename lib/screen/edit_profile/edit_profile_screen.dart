import 'package:flutter/material.dart';
import 'package:social_app/componets/componets.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return defaultAppBarr(
      title: 'Edit Profile',
      action: [
        defaultButton(fanction: () {},
            text: 'Update'
        ),
      ],
      context: context,
    );
  }
}
