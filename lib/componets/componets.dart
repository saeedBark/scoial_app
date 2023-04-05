import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/remote/sharedPreference/shared_preference.dart';
import 'package:social_app/style/colors.dart';

Widget defaultText(
    {
      String text,
      double fontSize,
      FontWeight fontWeidght,
      Color color}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontWeight: fontWeidght,
      fontSize: fontSize,

    ),
  );
}

////////// default FormFile//////////
Widget defaultFormFile({
 @ required TextEditingController controller,
  Function onsubmit,
  @required String lable,
  @required IconData prefix,
  Function onTap,
  TextInputType type,
  @required Function validator,
  IconData suffix,
  bool enable = true,
  bool isPassword = false,
}) =>
    TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: type,
      onFieldSubmitted: onsubmit,
      validator:validator,
      onTap: onTap,
      enabled: enable,
      decoration: InputDecoration(
        labelText: lable,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null ? Icon(suffix) : null,
        border: OutlineInputBorder(),
      ),
    );
////////////////
Future navigatorAndReplace(context , widget) =>  Navigator.
pushAndRemoveUntil(context, MaterialPageRoute(builder: (contex) => widget ), (route) => false);
///////// defaultAppBarr new post/////
Widget defaultAppBarr({
 String title,
@required List<Widget> action,
@required  context,

}){
  return AppBar(
    title: Text(title),
    titleSpacing: 5,
    leading: IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
      icon: Icon(Icons.arrow_back_ios),
    ),
    actions: action,
  );
}
//////
Widget defaultButton({
  Color color = defaultColor,
  double width = double.infinity,
  double raduis = 5,
  bool isUpperCase = true,
  @required Function fanction,
  @required String text,
}) {
  return Container(
    height: 40,
    width: width,
    child: MaterialButton(
      onPressed: () {
        fanction();
      },
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: TextStyle(color: Colors.white),
      ),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(raduis),
      color: color,
    ),
  );
}
/////////

var uId = SharedPreferenceCach.getData(key: 'uId');

////////// ShowToast //////
Future<bool> showToast({
  String text ,
  Color color,
}) {
  return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      //textColor: Colors.white,
      fontSize: 16.0);
}
