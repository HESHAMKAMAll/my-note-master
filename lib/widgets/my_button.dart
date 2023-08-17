import 'package:flutter/material.dart';

class MyButton extends StatelessWidget{
  MyButton({super.key,required this.onPressed,required this.title,required this.color,required this.Width});
  VoidCallback onPressed;
  String title;
  Color color;
  double Width;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: BorderSide(color: Colors.pink),
      ),
      onPressed: onPressed,
      child: Text(title,style: TextStyle(color: Colors.white, fontSize: 18,fontFamily: 'Pacifico')),
      color: color,
      elevation: 30,
      minWidth: Width,
      height: 60,
    );
  }

}