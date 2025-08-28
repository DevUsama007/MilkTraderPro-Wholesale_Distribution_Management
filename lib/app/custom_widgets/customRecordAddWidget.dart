import 'package:flutter/material.dart';
import 'package:khata_app/app/custom_widgets/addNewRecordWidget.dart';
import 'package:khata_app/app/custom_widgets/customBottomSheet.dart';
import 'package:khata_app/app/utils/calender_utils.dart';

class Customrecordaddwidget extends StatefulWidget {
  int year;
  String month;
  String chkName;
  String clientName;
  Customrecordaddwidget(
      {super.key,
      required this.year,
      required this.month,
      required this.chkName,
      required this.clientName});

  @override
  State<Customrecordaddwidget> createState() => _CustomrecordaddwidgetState();
}

class _CustomrecordaddwidgetState extends State<Customrecordaddwidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          "Choose Date",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        Divider(),
        SizedBox(
          height: 20,
        ),
        Container(
          child: Wrap(
            children: List.generate(
              CalenderUtils.getDaysInCurrentMonth(),
              (index) {
                return Card(
                  child: InkWell(
                    onTap: () {
                      CustomBottomSheet.show(
                          context: context,
                          child: AddNewRecordWidget(
                              year: widget.year,
                              chkName: widget.chkName,
                              month: widget.month,
                              todayDate:
                                  int.tryParse("${index + 1}".toString()) ?? 0,
                              clientName: widget.clientName));
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      child: Center(
                        child: Text("${index + 1}"),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
