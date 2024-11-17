
import 'package:durub_ali/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OrderDataSource extends DataGridSource {
  OrderDataSource({required List<order_model> orders}) {
    dataGridRows = orders
        .map<DataGridRow>((order) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'orderNumber', value: order.orderNumber),
      DataGridCell<String>(columnName: 'weight', value: order.weight),
      DataGridCell<String>(columnName: 'serviceType', value: order.serviceType),
      DataGridCell<String>(columnName: 'deliveryCost', value: order.deliveryCost),
      DataGridCell<String>(columnName: 'recipientName', value: order.recipientName),
      DataGridCell<String>(columnName: 'paymentMethod', value: order.paymentMethod),
      DataGridCell<String>(columnName: 'parcelCount', value: order.parcelCount),
      DataGridCell<String>(columnName: 'notes', value: order.notes),
      DataGridCell<String>(columnName: 'username', value: order.username),
      DataGridCell<String>(columnName: 'lastUpdated', value: order.lastUpdated),
    ]))
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
    );
  }
}