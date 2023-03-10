import 'package:flutter/material.dart';
import 'package:social_app/style/colors.dart';

Widget defaultText(
    { String text,
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
/////////


Widget defaultButton({
  Color color = defaultColor,
  double width = double.infinity,
  double raduis = 15,
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