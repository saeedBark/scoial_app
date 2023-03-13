import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/componets/componets.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/layout.dart';
import 'package:social_app/remote/sharedPreference/shared_preference.dart';
import 'package:social_app/screen/login/login_screen.dart';
import 'package:social_app/style/bloc_observe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
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
      create: (context) => SocialCubit()..getUser(),
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
          primarySwatch: Colors.pink,
          textTheme: const TextTheme(
            titleLarge: TextStyle(color: Colors.black, fontSize: 20),
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
