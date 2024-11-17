import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:durub_ali/data_sources/order_data_source.dart';
import 'package:durub_ali/durub/durub.dart';
import 'package:durub_ali/screens/ManageShipments/widget/CustomButton.dart';
import 'package:durub_ali/screens/ManageShipments/widget/CustomContainer.dart';
import 'package:durub_ali/models/order_model.dart';
import 'package:durub_ali/screens/ManageShipments/widget/CustomSwitchBar.dart';
import 'package:durub_ali/screens/ManageShipments/widget/Customtext.dart';
import 'package:durub_ali/screens/ManageShipments/widget/buildGridColumn.dart';
import 'package:durub_ali/screens/ManageShipments/widget/customFilterOptions.dart';
import 'package:durub_ali/screens/dashboard/header/header.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
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
  // final ScrollController _horizontalScrollController = ScrollController();
  // final ScrollController _verticalScrollController = ScrollController();

  DocumentSnapshot? _lastDocument;
  bool _isLoading = false;
  bool _isSwitched = true;
  List<order_model> _orders = [];
  int _batchSize = 20;

  @override
  void initState() {
    _orderDataSource = OrderDataSource(orders: _orders);
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    if (_isLoading) return;


   if(_batchSize==20){
     setState(() {
       _isLoading = true;
     });
   }


    Query query = FirebaseFirestore.instance
        .collection('orders')
        .limit(_batchSize);

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    QuerySnapshot snapshot = await query.get();
    if (snapshot.docs.isNotEmpty) {
      _lastDocument = snapshot.docs.last;
      List<order_model> newOrders = snapshot.docs.map((doc) {
        return order_model(
          orderNumber: doc['orderNumber'].toString(),
          weight: doc['weight'].toString(),
          serviceType: doc['serviceType'].toString(),
          deliveryCost: doc['deliveryCost'].toString(),
          recipientName: doc['recipientName'].toString(),
          paymentMethod: doc['paymentMethod'].toString(),
          parcelCount: doc['parcelCount'].toString(),
          notes: doc['notes'].toString(),
          username: doc['username'].toString(),
          lastUpdated: doc['lastUpdated'].toString(),
        );
      }).toList();

      setState(() {
        _orders.addAll(newOrders);
        _orderDataSource = OrderDataSource(orders: _orders);
      });
    }
    if(_batchSize==20) {
      setState(() {
        _isLoading = false;
      });
    }
  }


  Future<void> _handleLoadMore() async {
    _batchSize+=10;
    await _fetchOrders();
  }




  late OrderDataSource _orderDataSource;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const header(),
      Padding(
        padding: const EdgeInsets.only(top: 20,right: 30,left: 20),
        child:Wrap(
          alignment: WrapAlignment.spaceBetween,
          runAlignment: WrapAlignment.spaceBetween,
          runSpacing: 5.0,
          spacing: 5.0,
          children: [
           const Text("إدارة الطرود"),
            const SizedBox(width: 30,),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              runAlignment: WrapAlignment.center,
              children: [
                IconButton(onPressed: (){

                }, icon: Icon(Icons.refresh)),
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
                        onSelected: (value) {},
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
                      mainAxisSize: MainAxisSize.min,
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
                const customFilterOptions(),
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
          color: const Color(0xfffefaf3),
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
            const SizedBox(width: 20,),

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
              padding: const EdgeInsets.only(top: 20, right: 15, bottom: 50),
              alignment: Alignment.topRight,
              child:_isLoading && _orders.isEmpty
                  ? const Center(child: CircularProgressIndicator()) :
              SfDataGrid(
                source: _orderDataSource,
                showCheckboxColumn: true,
                isScrollbarAlwaysShown:true,
                columnWidthMode: ColumnWidthMode.auto,
                selectionMode: SelectionMode.multiple,
                frozenColumnsCount: 2,
                allowSorting: true,
                allowMultiColumnSorting: true,
                loadMoreViewBuilder: (BuildContext context, LoadMoreRows loadMoreRows) {
                  return FutureBuilder<void>(
                    future: _handleLoadMore(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        loadMoreRows();
                      }
                      return Container(
                        height: 60.0,
                        alignment: Alignment.center,
                        child: snapshot.connectionState == ConnectionState.waiting
                            ? const CircularProgressIndicator()
                            : const Text('تم تحميل جميع البيانات'),
                      );
                    },
                  );
                },
                columns: <GridColumn>[
                  buildGridColumn(columnName: 'orderNumber', labelText: 'رقم الطلب'),
                  buildGridColumn(columnName: 'weight', labelText: 'وزن الطرد (كغم)'),
                  buildGridColumn(columnName: 'serviceType', labelText: 'نوع الخدمة'),
                  buildGridColumn(columnName: 'deliveryCost', labelText: 'السعر'),
                  buildGridColumn(columnName: 'recipientName', labelText: 'اسم المستلم'),
                  buildGridColumn(columnName: 'paymentMethod', labelText: 'طريقة الدفع'),
                  buildGridColumn(columnName: 'parcelCount', labelText: 'عدد الطرود'),
                  buildGridColumn(columnName: 'notes', labelText: 'ملاحظات'),
                  buildGridColumn(columnName: 'username', labelText: 'اسم المستخدم'),
                  buildGridColumn(columnName: 'lastUpdated', labelText: 'آخر تحديث'),
                ],
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



