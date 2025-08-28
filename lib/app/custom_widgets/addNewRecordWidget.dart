import 'package:flutter/material.dart';
import 'package:khata_app/app/custom_widgets/custom_button_widget.dart';
import 'package:khata_app/app/res/app_colors.dart';
import 'package:khata_app/app/res/app_text_styles.dart';
import 'package:khata_app/app/utils/notification_utils.dart';
import 'package:khata_app/app/view_model/recordScreen_view_model.dart';
import 'package:provider/provider.dart';

import 'custom_text_field_widget.dart';

class AddNewRecordWidget extends StatefulWidget {
  int year;
  String month;
  String chkName;
  int todayDate;
  String clientName;
  AddNewRecordWidget(
      {super.key,
      required this.year,
      required this.chkName,
      required this.month,
      required this.todayDate,
      required this.clientName});

  @override
  State<AddNewRecordWidget> createState() => _AddNewRecordWidgetState();
}

class _AddNewRecordWidgetState extends State<AddNewRecordWidget> {
  final milkWieght = TextEditingController();
  final comments = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Add New Record',
              style: AppTextStyles.customText(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.blueAccent)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(widget.clientName.toString().toUpperCase()),
                    ),
                  ],
                ),
              ),
            ),
            Consumer<RecordscreenViewModel>(
              builder: (context, value, child) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black.withOpacity(0.2)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          value.milkTime,
                        ),
                        PopupMenuButton(
                          icon: Icon(Icons.arrow_drop_down),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                onTap: () {
                                  value.updateMilkTime('Morning');
                                },
                                child: Text("Morning")),
                            PopupMenuItem(
                                onTap: () {
                                  value.updateMilkTime('Evening');
                                },
                                child: Text("Evening"))
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            wieghtTextField(
                controller: milkWieght,
                hinttext: 'Enter the wieght',
                label: 'Wieght'),
            SizedBox(
              height: 10,
            ),
            CustomTextFieldWidget(
                minLines: 3,
                controller: comments,
                hinttext: 'Enter Comments',
                label: 'Comments'),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.blueAccent)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                          "Date: ${widget.todayDate.toString()}/${widget.month.toString()}/${widget.year.toString()}"),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButtonWidget(
                  btnColor: const Color.fromARGB(255, 203, 202, 202),
                  title: 'Cancel',
                  btnWidth: 0.35,
                  ontap: () {
                    Navigator.pop(context);
                  },
                ),
                Consumer<RecordscreenViewModel>(
                  builder: (context, value, child) {
                    return value.addingRecord
                        ? Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ))
                        : CustomButtonWidget(
                            btnColor: Colors.blueAccent,
                            title: 'Submit',
                            btnWidth: 0.35,
                            ontap: () async {
                              double? milk = double.tryParse(milkWieght.text);
                              if (milkWieght.text.toString().isEmpty) {
                                NotificationUtils.customNotification(context,
                                    'Field Error', 'Check The Fields', false);
                              } else {
                                if (value.milkTime == 'Morning') {
                                  Map<String, dynamic> data = {
                                    'date':
                                        "${widget.todayDate} ${widget.month}",
                                    'totalWieght':
                                        double.tryParse(milkWieght.text) ?? 0.0,
                                    'morningMilk':
                                        double.tryParse(milkWieght.text) ?? 0.0,
                                  };
                                  await value.addRecordMorning(
                                      context,
                                      data,
                                      widget.year,
                                      widget.month,
                                      widget.chkName,
                                      widget.todayDate,
                                      widget.clientName.toString().trim(),
                                      comments.text.toString());

                                  Navigator.pop(context);
                                } else {
                                  Map<String, dynamic> data = {
                                    'date':
                                        "${widget.todayDate} ${widget.month}",
                                    'eveningMilk':
                                        double.tryParse(milkWieght.text) ?? 0.0,
                                  };
                                  await value.addRecordEvening(
                                      context,
                                      data,
                                      widget.year,
                                      widget.month,
                                      widget.chkName,
                                      widget.todayDate,
                                      widget.clientName.toString().trim(),
                                      comments.text.toString());

                                  Navigator.pop(context);
                                }
                              }
                            },
                          );
                  },
                )
              ],
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}

class wieghtTextField extends StatefulWidget {
  TextEditingController controller;
  String label;
  String hinttext;
  int? minLines;
  wieghtTextField(
      {super.key,
      required this.controller,
      required this.hinttext,
      this.minLines = 1,
      required this.label});

  @override
  State<wieghtTextField> createState() => _wieghtTextFieldState();
}

class _wieghtTextFieldState extends State<wieghtTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      maxLines: 3,
      minLines: widget.minLines,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      cursorColor: AppColors.appBarColor,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.appBarColor),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.appBarColor)),
          label: Text(
            widget.label,
            style: TextStyle(color: AppColors.appBarColor, fontSize: 12),
          ),
          hintStyle:
              TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.5)),
          hintText: widget.hinttext),
    );
  }
}
