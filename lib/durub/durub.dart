import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const FontFamily = "Almarai";


class durub{
}

class DatePickerService {

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  //final Locale locale;

  DatePickerService({
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    //this.locale = const Locale('ar', 'JO'),
  });


  Future<DateTime?> selectDate(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      //locale: locale,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }
}