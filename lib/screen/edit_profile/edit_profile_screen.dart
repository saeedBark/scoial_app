import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/componets/componets.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/state.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel.name;
        bioController.text = userModel.bio;
        phoneController.text = userModel.phone;
        return Scaffold(
          appBar: defaultAppBarr(
            title: 'Edit Profile',
            action: [
              TextButton(
                onPressed: () {
                  cubit.updateUser(
                    name: nameController.text,
                    bio: bioController.text,
                    phone: phoneController.text,
                  );
                },
                child: const Text(
                  'Update',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
            context: context,
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is SocialUdateUserLoadingState)
                    LinearProgressIndicator(),
                  Container(
                    height: 190,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                  height: 140,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4),
                                    ),
                                    image: DecorationImage(
                                      image: coverImage == null
                                          ? NetworkImage(
                                              userModel.cover,
                                            )
                                          : FileImage(coverImage),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                    radius: 15,
                                    child: IconButton(
                                      onPressed: () {
                                        SocialCubit.get(context).getCover();
                                      },
                                      icon: const Icon(
                                        Icons.camera_alt_outlined,
                                        size: 15,
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              child: CircleAvatar(
                                radius: 55,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: profileImage == null
                                      ? NetworkImage(userModel.image)
                                      : FileImage(profileImage),
                                ),
                              ),
                            ),
                            CircleAvatar(
                                radius: 15,
                                child: IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context).getImage();
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt_outlined,
                                      size: 15,
                                    )))
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (cubit.profileImage != null || cubit.coverImage != null)
                    Row(
                      children: [
                        if (cubit.profileImage != null)
                          Expanded(
                              child: Column(
                            children: [
                              defaultButton(
                                  fanction: () {
                                    cubit.uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  text: 'Upload Profile '),
                              if (state is SocialUdateUserLoadingState)
                              SizedBox(height: 5,),
                              if (state is SocialUdateUserLoadingState)
                              LinearProgressIndicator(),
                            ],
                          )),
                        SizedBox(
                          width: 10,
                        ),
                        if (cubit.coverImage != null)
                          Expanded(
                              child: Column(
                            children: [
                              defaultButton(
                                  fanction: () {
                                    cubit.uploadCoverImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text);
                                  },
                                  text: 'Upload Cover '),
                              if (state is SocialUdateUserLoadingState)
                              SizedBox(height: 5,),
                              if (state is SocialUdateUserLoadingState)
                              LinearProgressIndicator(),
                            ],
                          )),
                      ],
                    ),
                  if (cubit.profileImage != null || cubit.coverImage != null)
                    SizedBox(
                      height: 25,
                    ),
                  defaultFormFile(
                    controller: nameController,
                    lable: 'name',
                    type: TextInputType.text,
                    prefix: Icons.person_2_outlined,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormFile(
                    controller: bioController,
                    type: TextInputType.text,
                    lable: 'Bio...',
                    prefix: Icons.info_outline,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'bio must not be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormFile(
                    controller: phoneController,
                    type: TextInputType.phone,
                    lable: 'phone',
                    prefix: Icons.info_outline,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
