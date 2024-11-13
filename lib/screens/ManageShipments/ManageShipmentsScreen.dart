import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:durub_ali/screens/ManageShipments/widget/CustomScrollbar.dart';
import 'package:durub_ali/screens/dashboard/header/header.dart';
import 'package:flutter/material.dart';

class ManageShipmentsScreen extends StatefulWidget {
  const ManageShipmentsScreen({super.key});

  @override
  State<ManageShipmentsScreen> createState() => _ManageShipmentsScreenState();
}

class _ManageShipmentsScreenState extends State<ManageShipmentsScreen> {
  final ScrollController _scrollController = ScrollController();
  final int _limitIncrement = 20;
  int _limit = 20;
  bool _isLoading = false;

  List<DocumentSnapshot> orders = [];

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
        .collection('orders')
        .limit(_limit)
        .get().catchError((error){
      print("|-------------------EX--------------------|");
      print("|-------------------EX--------------------|");
      print(error);
      print("|-------------------EX--------------------|");
      print("|-------------------EX--------------------|");
         });

    snapshot.docs.map((e){
      print("|--------------------------------------------|");
      print("|--------------------------------------------|");
      print(e.data());
      print("|--------------------------------------------|");
      print("|--------------------------------------------|");
    }).toList();

    setState(() {
      orders = snapshot.docs;
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
                DataColumn(label: Text('رقم الشحنة')),
                DataColumn(label: Text('وزن الطرد(كغم)')),
                DataColumn(label: Text('نوع الخدمة')),
                DataColumn(label: Text('السعر')),
                DataColumn(label: Text('اسم المستلم')),
                DataColumn(label: Text('طريقة الدفع')),
                DataColumn(label: Text('عدد الطرود')),
                DataColumn(label: Text('ملاحظات')),
                DataColumn(label: Text('اسم المستخدم')),
                DataColumn(label: Text('آخر تحديث')),
                DataColumn(label: Text('رقم الطلب')),
              ],
              rows: orders.map<DataRow>((user) {
                return DataRow(
                  cells: [
                    DataCell(Text(get_str(user['orderId']))),
                    DataCell(Text(get_str(user['weight']))),
                    DataCell(Text(get_str(user['serviceType']))),
                    DataCell(Text(get_str("${user['deliveryCost']} JOD"))),
                    DataCell(Text(get_str(user['recipientName']))),
                    DataCell(Text(get_str(user['paymentMethod']))),
                    DataCell(Text(get_str(user['parcelCount'].toString()))),
                    DataCell(Text(get_str(user['notes'] ?? ''))),
                    DataCell(Text(get_str(user['username']))),
                    DataCell(Text(get_str(user['lastUpdated']))),
                    DataCell(Text(get_str(user['orderNumber'].toString()))),
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
    if(value!="" && value!=null){
      return value;
    }
    return "";
  }
}
