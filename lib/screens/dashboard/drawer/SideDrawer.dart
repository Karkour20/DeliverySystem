import 'package:durub_ali/screens/dashboard/drawer/widget/customListTile.dart';
import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTileSelected;
  SideDrawer({super.key,required this.selectedIndex,required this.onTileSelected});


  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 1.0,
      width: 180,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0)
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 10,
            decoration: const BoxDecoration(
              color: Colors.red,
            ),
          ),
          SizedBox(
            height: 180,
            child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      width: double.infinity,
                      height: 100,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.vertical(
                            // top: Radius.elliptical(50, 100),
                              bottom: Radius.circular(20),
                          ),
                        ),
                      ),
                  ),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment.center,
                          child: Material(
                              borderRadius: BorderRadius.circular(5),
                              elevation: 1.0,
                              child:ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset("assets/images/company-logo.png",
                                  width:150,height: 115,),
                              ), ))),
                  const Positioned.fill(
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text("SpeedDirection"))),
                ]),
          ),
          Expanded(
            child: ListView(
              children: [
                customListTile(selected: selectedIndex == 0,icon: Icons.dashboard,title: 'الملخص',onTap: () => onTileSelected(0)),
                customListTile(selected: selectedIndex == 1,icon: Icons.local_shipping,title: 'إدارة الطرود',onTap: () => onTileSelected(1)),
                customListTile(selected: selectedIndex == 2,icon: Icons.track_changes,title: 'المتابعات',onTap: () => onTileSelected(2)),
                customListTile(icon: Icons.assignment_return,title: 'إدارة الرواجع',children: [
                  customListTile(selected: selectedIndex == 3,icon: Icons.home,title: 'شاشة استلام الطرود',onTap: () => onTileSelected(3)),
                ],),
                customListTile(selected: selectedIndex == 4,icon: Icons.report,title:'تقارير حالية',onTap: () => onTileSelected(4)),
                customListTile(selected: selectedIndex == 5,icon: Icons.people,title:'إدارة المركبات',onTap: () => onTileSelected(5)),
                customListTile(selected: selectedIndex == 6,icon: Icons.directions_car,title:'إدارة المستخدمين',onTap: () => onTileSelected(6)),
                customListTile(selected: selectedIndex == 7,icon: Icons.store,title:'إدارة الفروع',onTap: () => onTileSelected(7)),
                customListTile(selected: selectedIndex == 8,icon: Icons.print,title:'التقارير المطبوعة',onTap: () => onTileSelected(8)),
                customListTile(icon: Icons.account_balance_wallet,title:'المحاسبة',children: [
                  customListTile(selected: selectedIndex == 9,icon: Icons.home,title: 'عهدة الفرع',onTap: () => onTileSelected(9)),
                ],),
                customListTile(selected: selectedIndex == 10,icon: Icons.admin_panel_settings,title:'الادارة',onTap: () => onTileSelected(10)),
                customListTile(selected: selectedIndex == 11,icon: Icons.info,title:'معلومات',onTap: () => onTileSelected(11)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
