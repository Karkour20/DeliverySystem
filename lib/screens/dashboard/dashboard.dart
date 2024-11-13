import 'package:durub_ali/durub/colors.dart';
import 'package:durub_ali/screens/ManageShipments/ManageShipmentsScreen.dart';
import 'package:durub_ali/screens/dashboard/drawer/SideDrawer.dart';
import 'package:durub_ali/screens/dashboard/widget/customBox.dart';
import 'package:durub_ali/screens/users/UsersScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'dashboardScreen.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  int selectedIndex = 0;

  void onTileSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Row(
        children: [
          SideDrawer(
              selectedIndex: selectedIndex,
              onTileSelected: onTileSelected),
          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: [
                dashboardScreen(),
                ManageShipmentsScreen(),
                UsersScreen()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
