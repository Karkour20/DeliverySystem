import 'package:durub_ali/durub/colors.dart';
import 'package:durub_ali/screens/dashboard/header/header.dart';
import 'package:durub_ali/screens/dashboard/widget/customBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class dashboardScreen extends StatefulWidget {
  const dashboardScreen({super.key});

  @override
  State<dashboardScreen> createState() => _dashboardScreenState();
}

class _dashboardScreenState extends State<dashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const header(),
      Container(
        padding: const EdgeInsets.only(top: 20,right: 15),
        alignment: Alignment.topRight,
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                alignment: Alignment.topRight,
                child: const Text("المخلص",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),),
              ),

              Column(
                children: [
                  const SizedBox(width: 40,),
                  Row(
                    children: [
                      Expanded(child: customBox(title:'الطلبات الجديدة' ,is_color: true,)),
                      Expanded(child: customBox(title:'بأنتظار تعيين السائق' ,)),
                      Expanded(child: customBox(title:'في المركبة' ,)),
                      Expanded(child: customBox(title:'تم إرجاعها' ,)),
                      Expanded(child: customBox(title:'مؤجلة لوقت اخر' ,)),
                      Expanded(child: customBox(title:'مغلقة' ,)),
                    ],
                  ),
                ],
              )
            ],
          ),),
      )
    ],);
  }
}
