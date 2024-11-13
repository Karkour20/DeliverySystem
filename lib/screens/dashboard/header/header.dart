import 'package:durub_ali/durub/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class header extends StatelessWidget {
  const header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            height: 70,
            color: Colors.white,
            child:Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 20),
              child: Material(
                elevation: 0.5,
                child:Wrap(
                  alignment:WrapAlignment.start,
                  children: [
                    const SizedBox(width: 10,),
                    SvgPicture.asset("assets/package-icon.svg"),
                    const SizedBox(width: 10,),
                    Container(
                      color:secprimary,
                      child: const SizedBox(
                        height:30.0,
                        width:3.0,
                        child:Divider(
                          thickness:10,
                          color:secprimary,),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Container(
                      width: 300,
                      child: const TextField(
                        decoration: InputDecoration(
                          labelText: 'أدخل رقم الطرد , الارسالية ,أو المستلم للمتابعة',
                          labelStyle: TextStyle(
                              fontSize: 12
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
