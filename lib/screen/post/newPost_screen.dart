import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/componets/componets.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/state.dart';

class NewPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var textController = TextEditingController();
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: defaultAppBarr(
              title: 'Creat Post',
              action: [
                TextButton(
                    onPressed: () {
                      var now = DateTime.now();
                      if (cubit.postImage == null) {
                        cubit.createPost(
                          dateTime: now.toString(),
                          text: textController.text,
                        );
                      }
                      else {
                        cubit.uploadPostImage(
                          dateTime: now.toString(),
                          text: textController.text,
                        );
                      }
                    },
                    child: const Text(
                      'Post',
                      style: TextStyle(fontSize: 20),
                    ),
                ),
              ],
              context: context),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                      LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                            'https://www.sayidaty.net/sites/default/files/styles/600x380/public/2023-03/222113.jpg?h=ea95bb15'),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Saeed bark',
                              style: TextStyle(height: 1.3, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                        hintText: 'What is on your mind .......',
                        border: InputBorder.none),
                  ),
                ),
                if(cubit.postImage !=null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                          height: 140,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius:  BorderRadius.circular(15),
                            image: DecorationImage(
                              image: FileImage(cubit.postImage),
                              fit: BoxFit.cover,
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircleAvatar(
                            radius: 20,
                            child: IconButton(
                              onPressed: () {
                                SocialCubit.get(context).removePostImage();
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 16,
                              ),
                            )),
                      )
                    ],
                  ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            cubit.getPost();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image_outlined),
                              SizedBox(
                                width: 5,
                              ),
                              Text('add photo'),
                            ],
                          )),
                    ),
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: Text('# tags')))
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
