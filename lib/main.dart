import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/componets/componets.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/layout.dart';
import 'package:social_app/remote/sharedPreference/shared_preference.dart';
import 'package:social_app/screen/login/login_screen.dart';
import 'package:social_app/style/bloc_observe.dart';

Future<void> firebaseMessagingBackgroundHander(RemoteMessage message) async
{
  print('on background message');
  print(message.data.toString());
  showToast(text: 'on message',color: Colors.green);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  print(token);
  // at application recive notification
  FirebaseMessaging.onMessage.listen((event) {
    print('on message');
    print(event.data.toString());
    showToast(text: 'on message',color: Colors.green);

  });

  // when click on notification to open app background

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on message opened app');
    print(event.data.toString());
    showToast(text: 'on message opened app' ,color: Colors.blue);
  });
  // background fcm
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHander);
  Bloc.observer = MyBlocObserver();
  await SharedPreferenceCach.inti();

  Widget widget;
  if (uId != null) {
    widget = LayoutScreen();
  } else {
    widget = LoginScreen();
  }

  runApp(SocialApp(
    starWidget: widget,
  ));
}

class SocialApp extends StatelessWidget {
  //final String uid;
  final Widget starWidget;


  const SocialApp({Key key, this.starWidget, }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit()..getUser()..getPosts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              titleTextStyle: TextStyle(color: Colors.black, fontSize: 24),
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
              ),
              iconTheme: IconThemeData(
                color: Colors.black,
              )),
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue,
          textTheme:  TextTheme(
            titleLarge: TextStyle(color: Colors.black, fontSize: 14),
            titleMedium:  TextStyle(color: Colors.black, fontSize: 14,height: 1.3,fontWeight: FontWeight.bold),
          ),

          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            selectedItemColor: Colors.deepOrange,
            unselectedItemColor: Colors.grey,
            elevation: 0,
          ),
        ),
        home: starWidget,
      ),
    );
  }
}
