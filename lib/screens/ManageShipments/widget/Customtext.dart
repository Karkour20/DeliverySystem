import 'package:flutter/material.dart';

class Customtext extends StatelessWidget {
  String title;
  Customtext({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(get_str(title),
      textAlign: TextAlign.center,),
    );
  }
  String get_str(String value){
    if(value!="" && value!=null){
      return value;
    }
    return "";
  }
}
