import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 20,
            margin: EdgeInsets.all(8),
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
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: EdgeInsets.only(left: 8, right: 8, bottom: 8),
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
                            'https://www.sayidaty.net/sites/default/files/styles/600x380/public/2023-03/222113.jpg?h=ea95bb15'),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Saeed bark',
                                  style: TextStyle(
                                    height: 1.3,
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.blue,
                                  size: 17,
                                ),
                              ],
                            ),
                            Text(
                              'march 21,5,2023 at 10: pm',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  .copyWith(
                                    height: 1.3,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.more_horiz),
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
                    'Teaching is a highly complex activity.[6] This is partially because teaching is a social practice, that takes place in a specific context (time, place, culture, socio-political-economic situation etc.) and therefore is shaped by the values of that specific context.[7] Factors that influence what is expected (or required) of teachers include history and tradition, social views about the purpose of education, accepted theories about',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      width: double.infinity,
                      child: Wrap(
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.only(end: 10),
                            child: Container(
                              height: 25,
                              child: MaterialButton(
                                padding: EdgeInsets.zero,
                                minWidth: 1,
                                onPressed: () {},
                                child: Text('#software',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        .copyWith(color: Colors.blue)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(end: 10),
                            child: Container(
                              height: 25,
                              child: MaterialButton(
                                padding: EdgeInsets.zero,
                                minWidth: 1,
                                onPressed: () {},
                                child: Text('#flutter',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        .copyWith(color: Colors.blue)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://www.sayidaty.net/sites/default/files/styles/600x380/public/2023-03/222113.jpg?h=ea95bb15',
                          ),
                          fit: BoxFit.cover,
                        ),
                      )),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Row(
                            children: [
                              Icon(
                                Icons.favorite_outline,
                                size: 18,
                                color: Colors.red,
                              ),
                              SizedBox(
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
                              Icon(
                                Icons.chat,
                                size: 18,
                                color: Colors.amber,
                              ),
                              SizedBox(
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
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.grey[300],
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                                'https://www.sayidaty.net/sites/default/files/styles/600x380/public/2023-03/222113.jpg?h=ea95bb15'),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Saeed bark',
                                      style: TextStyle(
                                        height: 1.3,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.blue,
                                      size: 17,
                                    ),
                                  ],
                                ),
                                Text(
                                  'march 21,5,2023 at 10: pm',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      .copyWith(
                                        height: 1.3,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.more_horiz),
                          ),
                        ],
                      ),
                    ],
                  )

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
