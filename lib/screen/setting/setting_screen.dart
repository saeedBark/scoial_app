import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/state.dart';

class SettingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
    listener: (context, state) {
      // TODO: implement listener
    },
    builder: (context, state) {
      var userModel = SocialCubit.get(context).userModel;

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 190,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                          image:  DecorationImage(
                            image: NetworkImage(
                            userModel.cover,
                            ),
                            fit: BoxFit.cover,
                          ),
                        )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child:  CircleAvatar(
                      radius: 55,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            userModel.image),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            const SizedBox(height: 10,),
            Text(userModel.name,style: Theme.of(context).textTheme.bodyLarge,),
            const SizedBox(height: 5,),
            Text(userModel.bio,style: Theme.of(context).textTheme.bodySmall,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text('56',style: Theme.of(context).textTheme.titleMedium,),
                          Text('Posts',style: Theme.of(context).textTheme.bodySmall,),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text('200',style: Theme.of(context).textTheme.titleMedium,),
                          Text('Photos',style: Theme.of(context).textTheme.bodySmall,),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text('250k',style: Theme.of(context).textTheme.titleMedium,),
                          Text('Followers',style: Theme.of(context).textTheme.bodySmall,),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text('56',style: Theme.of(context).textTheme.titleMedium,),
                          Text('Followings',style: Theme.of(context).textTheme.bodySmall,),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),

                ],
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(child: OutlinedButton(
                  onPressed: (){},
                  child: const Text('Add Photos',),
                ),),
                const SizedBox(width: 10,),
                OutlinedButton(
                  onPressed: (){},
                  child: const Icon(Icons.edit,),
                ),
              ],
            ),
          ],
        ),
      );
    },
);
  }
}