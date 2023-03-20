import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/state.dart';
import 'package:social_app/model/post_model.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var cubit = SocialCubit.get(context);
    return ConditionalBuilder(
      condition:cubit.posts.length > 0,
      builder: (context) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 20,
              margin: const EdgeInsets.all(8),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Image.network(
                    'https://www.eu-startups.com/wp-content/uploads/2022/10/Screen-Shot-2022-10-04-at-10.06.13.png',
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'communicate with friends',
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => builderPostItem(context,cubit.posts[index]),
              separatorBuilder: (context,index ) => const SizedBox(height: 8,),
              itemCount: 10,
            ),
            const SizedBox(height: 8,),
          ],
        ),
      ),
      fallback:(context) => Center(child: CircularProgressIndicator()),
    );
  },
);
  }

  Widget builderPostItem(context,PostModel model) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      elevation: 20,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                 CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      model.image),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                           Text(
                            model.name,
                            style: TextStyle(
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          const Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 17,
                          ),
                        ],
                      ),
                      Text(
                        model.dateTime,
                        style: Theme.of(context).textTheme.bodySmall.copyWith(
                              height: 1.3,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey[300],
              ),
            ),
            Text(
             model.text,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            // // Padding(
            // //   padding: const EdgeInsets.symmetric(vertical: 8.0),
            // //   child: Container(
            // //     width: double.infinity,
            // //     child: Wrap(
            // //       children: [
            // //         Padding(
            // //           padding: const EdgeInsetsDirectional.only(end: 10),
            // //           child: Container(
            // //             height: 25,
            // //             child: MaterialButton(
            // //               padding: EdgeInsets.zero,
            // //               minWidth: 1,
            // //               onPressed: () {},
            // //               child: Text('#software',
            // //                   style: Theme.of(context)
            // //                       .textTheme
            // //                       .titleLarge
            // //                       .copyWith(color: Colors.blue)),
            // //             ),
            // //           ),
            // //         ),
            // //         Padding(
            // //           padding: const EdgeInsetsDirectional.only(end: 10),
            // //           child: Container(
            // //             height: 25,
            // //             child: MaterialButton(
            // //               padding: EdgeInsets.zero,
            // //               minWidth: 1,
            // //               onPressed: () {},
            // //               child: Text('#flutter',
            // //                   style: Theme.of(context)
            // //                       .textTheme
            // //                       .titleLarge
            // //                       .copyWith(color: Colors.blue)),
            // //             ),
            // //           ),
            // //         ),
            // //       ],
            // //     ),
            // //   ),
            // // ),

            Padding(
              padding: EdgeInsetsDirectional.only(top: 10),
              child: Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://www.sayidaty.net/sites/default/files/styles/600x380/public/2023-03/222113.jpg?h=ea95bb15',
                      ),
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.favorite_outline,
                            size: 18,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '350',
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.chat,
                            size: 18,
                            color: Colors.amber,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '910 comment',
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                              'https://www.sayidaty.net/sites/default/files/styles/600x380/public/2023-03/222113.jpg?h=ea95bb15'),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          'write a comment ...',
                          style: Theme.of(context).textTheme.bodySmall.copyWith(
                                height: 1.3,
                              ),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
                InkWell(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.favorite_outline,
                        size: 18,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '350',
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                  onTap: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
