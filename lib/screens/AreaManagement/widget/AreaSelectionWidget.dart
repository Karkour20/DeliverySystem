import 'package:durub_ali/durub/colors.dart';
import 'package:flutter/material.dart';

class AreaSelectionWidget extends StatefulWidget {
  @override
  _AreaSelectionWidgetState createState() => _AreaSelectionWidgetState();
}

class _AreaSelectionWidgetState extends State<AreaSelectionWidget> {
  List<String> areas = [
    "مسقط",
    "ظفار",
    "البريمي",
    "الداخلية",
    "الظاهرة",
    "شمال الشرقية",
    "جنوب الشرقية",
    "شمال الباطنة",
    "جنوب الباطنة",
    "مسندم",
  ];
  List<String> selectedAreas = [];
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          children: [
            const Text('المناطق', style: TextStyle(fontSize: 18)),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'بحث',

                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),


        Expanded(
          child: ListView(
            children: areas
                .where((area) => area.contains(searchController.text))
                .map((area) {
              return Container(
                margin: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                ),
                child: CheckboxListTile(
                  title: Text(area),
                  activeColor: Color(0xffaf5405),
                  value: selectedAreas.contains(area),
                  onChanged: (isChecked) {
                    setState(() {
                      if (isChecked!) {
                        selectedAreas.add(area);
                      } else {
                        selectedAreas.remove(area);
                      }
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ),


        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor:Color(0xffaf5405),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
              onPressed: () {

              },
              label: const Text('إضافة'),
              icon: Icon(Icons.add,size: 20,),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  foregroundColor:Color(0xffaf5405),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(width: 1.0,color: Color(0xffaf5405),)
                  )
              ),
              onPressed: () {
                // إضافة إجراء الحذف هنا
              },
              label: const Text('حذف'),
              icon: Icon(Icons.delete,size: 20,),

            ),
          ],
        ),
      ],
    );
  }
}