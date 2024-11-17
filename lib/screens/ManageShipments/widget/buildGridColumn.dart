import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

GridColumn buildGridColumn({
  required String columnName,
  required String labelText,
  Alignment alignment = Alignment.center,
}) {
  return GridColumn(
    columnName: columnName,
    label: Container(
      alignment: alignment,
      child: Text(
        labelText,
        textAlign: TextAlign.center,
      ),
    ),
  );
}

