import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MyField extends StatelessWidget{
  MyField({super.key,required this.maxLines,required this.textAlign,required this.hintText,required this.validator,this.onSaved});
  var onSaved;
  int maxLines;
  TextAlign textAlign;
  String hintText;
  var validator;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Get.isDarkMode ? Colors.white12:Colors.white60,
      borderRadius: BorderRadius.circular(17),
      elevation: 30,
      child: TextFormField(
        onSaved: onSaved,
        validator: validator,
        maxLines: maxLines,
        keyboardType: TextInputType.text,
        textAlign: textAlign,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontFamily: 'Pacifico'),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(17),
              borderSide: const BorderSide(color: Colors.black38)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(17),
              borderSide: const BorderSide(color: Colors.white12)),
        ),
      ),
    );
  }
}






class MyField2 extends StatelessWidget{
  MyField2({super.key,required this.controller,required this.maxLines,required this.textAlign,
    required this.hintText,required this.validator,required this.labelText,required this.obscureText,this.suffixIcon});
  TextEditingController controller;
  int maxLines;
  TextAlign textAlign;
  String hintText;
  String labelText;
  var validator;
  bool obscureText;
  var suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14,
        ),
        labelText: labelText,
        floatingLabelStyle: TextStyle(fontFamily: 'Pacifico'),
        labelStyle: TextStyle(
          fontSize: 15,
          color: Get.isDarkMode? Colors.pink:Color(0xFFFF6B6B),
        ),
        suffixIcon: suffixIcon
      ),
    );
  }
}