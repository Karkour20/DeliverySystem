import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:durub_ali/screens/ManageShipments/widget/CustomScrollbar.dart';
import 'package:durub_ali/screens/dashboard/header/header.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final ScrollController _scrollController = ScrollController();
  final int _limitIncrement = 20;
  int _limit = 20;
  bool _isLoading = false;

  List<DocumentSnapshot> users = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchUsers();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _fetchMoreUsers();
    }
  }

  Future<void> _fetchUsers() async {
    setState(() {
      _isLoading = true;
    });

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .limit(_limit)
        .get().catchError((error){

    });

    snapshot.docs.map((e){

    }).toList();

    setState(() {
      users = snapshot.docs;
      _isLoading = false;
    });
  }
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();
  Future<void> _fetchMoreUsers() async {
    setState(() {
      _limit += _limitIncrement;
    });
    await _fetchUsers();
  }
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const header(),
      Expanded(
        child: Container(
            padding: const EdgeInsets.only(
                top: 20,
                right: 15,
                bottom: 50),
            alignment: Alignment.topRight,
            child:CustomScrollbar(
              verticalScrollController: _verticalScrollController,
              horizontalScrollController: _horizontalScrollController,
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(label: Text('اسم مستخدم')),
                  DataColumn(label: Text('رقم الجوال')),
                  DataColumn(label: Text('الايميل')),
                  DataColumn(label: Text('عنوان')),
                ],
                rows: users.map<DataRow>((user) {
                  return DataRow(
                    cells: [
                      DataCell(Text(get_str(user['username']))),
                      DataCell(Text(get_str(user['phone number']))),
                      DataCell(Text(get_str(user['email']))),
                      DataCell(Text(get_str(user['address']))),
                    ],
                  );
                }).toList(),
              ),
            )
        ),
      )
    ],);
  }
  String get_str(String value){
    if(value!=null && value!=""){
      return value;
    }
    return "null";
  }
}
