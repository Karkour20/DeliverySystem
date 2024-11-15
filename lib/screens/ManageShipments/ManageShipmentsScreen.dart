import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:durub_ali/durub/durub.dart';
import 'package:durub_ali/screens/ManageShipments/widget/CustomButton.dart';
import 'package:durub_ali/screens/ManageShipments/widget/CustomContainer.dart';
import 'package:durub_ali/screens/ManageShipments/widget/CustomScrollbar.dart';
import 'package:durub_ali/screens/ManageShipments/widget/CustomSwitchBar.dart';
import 'package:durub_ali/screens/ManageShipments/widget/Customtext.dart';
import 'package:durub_ali/screens/ManageShipments/widget/customFilterOptions.dart';
import 'package:durub_ali/screens/dashboard/header/header.dart';
import 'package:flutter/material.dart';
final List<String> dates = [
  "تاريخ الحجز",
  "تاريخ التوصيل",
  "تاريخ أول تحميل",
  "تاريخ الارجاع",
  "تاريخ التأجيل",
  "تاريخ اخر حالة",
  "تاريخ التعديل",
  "تاريخ تعيين الشحنة للسائق",
];
class ManageShipmentsScreen extends StatefulWidget {
  const ManageShipmentsScreen({super.key});

  @override
  State<ManageShipmentsScreen> createState() => _ManageShipmentsScreenState();
}

class _ManageShipmentsScreenState extends State<ManageShipmentsScreen> {
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();
  final int _limitIncrement = 20;
  int _limit = 20;
  bool _isLoading = false;
  bool _isSwitched = true;
  List<DocumentSnapshot> orders = [];

  @override
  void initState() {
    super.initState();
    _verticalScrollController.addListener(_onScroll);
    _fetchUsers();
  }

  void _onScroll() {
    if (_verticalScrollController.position.pixels == _verticalScrollController.position.maxScrollExtent) {
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
        .get().catchError((error){});


    setState(() {
      orders = snapshot.docs;
      _isLoading = false;
    });
  }
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
      Padding(
        padding: const EdgeInsets.only(top: 20,right: 30,left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           const Text("إدارة الطرود"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.refresh),
                CustomSwitchBar(
                  label: 'شريط الأدوات',
                  value: _isSwitched,
                  onChanged: (value) {
                    setState(() {
                      _isSwitched = value;
                    });
                  },
                ),
                CustomContainer(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PopupMenuButton(
                        onSelected: (value) {

                          if (value == 'export_excel') {

                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'export_excel',
                            child: Row(
                              children: [
                                Icon(Icons.file_present, color: Colors.black54),
                                SizedBox(width: 8.0),
                                Text("تصدير Excel"),
                              ],
                            ),
                          ),
                        ],
                        child: const Row(
                          children: [
                            Icon(Icons.arrow_drop_down, color: Colors.black54),
                            SizedBox(width: 4.0),
                            Text(
                              'استيراد / تصدير',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Icon(Icons.description, color: Colors.black54),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                CustomContainer(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PopupMenuButton(
                        onSelected: (value) {
                        },
                        itemBuilder: (context) => dates.asMap().entries.map((entry) {
                          int index = entry.key;
                          String date = entry.value;

                          return PopupMenuItem<int>(
                            value: index,
                            child: Row(
                              children: [
                                Text(date),
                              ],
                            ),
                          );
                        }).toList(),
                        child: const Row(
                          children: [
                            Icon(Icons.arrow_drop_down, color: Colors.black54),
                            SizedBox(width: 4.0),
                            Text(
                              'تاريخ الججز',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Icon(Icons.calendar_month, color: Colors.black54),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                CustomContainer(
                  child: GestureDetector(
                    onTap: _pickDate,
                    child: const Row(
                      children: [
                        Icon(Icons.arrow_drop_down, color: Colors.black54),
                        SizedBox(width: 4.0),
                        Text(
                          'الكل',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Icon(Icons.calendar_month, color: Colors.black54),
                      ],
                    ),
                  ),
                ),
                customFilterOptions(),
                CustomContainer(
                  child: Container(
                    width: 120,
                    child: const TextField(
                      decoration: InputDecoration(
                        labelText: 'البحث',
                        labelStyle: TextStyle(
                            fontSize: 12
                        ),
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.search)
                      ),
                    ),
                  ),
                )

              ],
            )
          ],
        ),
      ),
      if(_isSwitched)
      Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Color(0xfffefaf3),
          borderRadius: BorderRadius.circular(15)
        ),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 5.0,
          runSpacing: 5.0,
          children: [
            CustomButton(
              text: 'استلام طرود من السائق',
              onPressed: () {

              },
              color: Colors.green,
              textColor: Colors.white,
              fontSize: 12.0,
              borderRadius: 10.0,
              // icon: Icons.check,
              iconColor: Colors.white,
              height: 30.0,
              isLoading: false,
            ),
            CustomButton(
              text: 'طباعة طرود السائق',
              onPressed: () {

              },
              color: Colors.green,
              textColor: Colors.white,
              fontSize: 12.0,
              borderRadius: 10.0,
              // icon: Icons.check,
              iconColor: Colors.white,
              height: 30.0,
              isLoading: false,
            ),
            CustomButton(
              text: 'قراءة بالباركود',
              onPressed: () {

              },
              color: Colors.green,
              textColor: Colors.white,
              fontSize: 12.0,
              borderRadius: 10.0,
              // icon: Icons.check,
              iconColor: Colors.white,
              height: 30.0,
              isLoading: false,
            ),
            SizedBox(width: 20,),

            ...list_btn.asMap().entries.map((entry) {
              int index = entry.key;
              String value = entry.value;

              return CustomButton(
                text: value,
                onPressed: () {

                },
                color: Colors.green,
                textColor: Colors.white,
                fontSize: 12.0,
                borderRadius: 10.0,
                // icon: Icons.check,
                iconColor: Colors.white,
                height: 30.0,
                isLoading: false,
                enabled: false,
              );
            }).toList(),
          ],
        ),
      ),
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
              dividerThickness: 1,
              columns: const <DataColumn>[
                DataColumn(label: Text('رقم الطلب')),
                DataColumn(label: Text('وزن الطرد(كغم)')),
                DataColumn(label: Text('نوع الخدمة')),
                DataColumn(label: Text('السعر')),
                DataColumn(label: Text('اسم المستلم')),
                DataColumn(label: Text('طريقة الدفع')),
                DataColumn(label: Text('عدد الطرود')),
                DataColumn(label: Text('ملاحظات')),
                DataColumn(label: Text('اسم المستخدم')),
                DataColumn(label: Text('آخر تحديث')),
                DataColumn(label: Text('رقم الشحنة')),
              ],
              rows: orders.map<DataRow>((user) {
                return DataRow(
                  cells: [
                    DataCell(Customtext(title:user['orderNumber'].toString())),
                    DataCell(Customtext(title:"${user['weight']!="" ? user['weight']:"0"}")),
                    DataCell(Customtext(title:user['serviceType'])),
                    DataCell(Customtext(title:"${user['deliveryCost']} JOD")),
                    DataCell(Customtext(title:user['recipientName'])),
                    DataCell(Customtext(title:user['paymentMethod'])),
                    DataCell(Customtext(title:user['parcelCount'].toString())),
                    DataCell(Customtext(title:user['notes'] ?? '')),
                    DataCell(Customtext(title:user['username'])),
                    DataCell(Customtext(title:user['lastUpdated'])),
                    DataCell(Customtext(title: user['orderId'],)),
                  ],
                );
              }).toList(),
            ),
          )
        ),
      )
    ],);
  }


  DateTime? selectedDate;


  final datePickerService = DatePickerService(
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );
  void _pickDate() async {
    final picked = await datePickerService.selectDate(context);
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
  List list_btn=[
    'مسار السائق التلقائي',
    'تغيير الحالة',
    'تعيين السائق',
    'طباعة التقرير',
    'طباعة سند القبض',
    'تصدير الى شريك',
    'تحديد مسار السائق'
  ];
}
