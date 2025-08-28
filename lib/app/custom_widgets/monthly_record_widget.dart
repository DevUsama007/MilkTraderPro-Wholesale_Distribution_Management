import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khata_app/app/custom_widgets/addNewRecordWidget.dart';
import 'package:khata_app/app/custom_widgets/custom_button_widget.dart';
import 'package:khata_app/app/custom_widgets/custom_text_field_widget.dart';
import 'package:khata_app/app/custom_widgets/error_display_widget.dart';
import 'package:khata_app/app/res/app_colors.dart';
import 'package:khata_app/app/res/app_text_styles.dart';
import 'package:khata_app/app/view_model/recordScreen_view_model.dart';
import 'package:khata_app/main.dart';
import 'package:provider/provider.dart';

class MonthlyRecordWidget extends StatefulWidget {
  String year;
  String month;
  String chkName;
  String clientName;

  MonthlyRecordWidget(
      {super.key,
      required this.year,
      required this.month,
      required this.chkName,
      required this.clientName});

  @override
  State<MonthlyRecordWidget> createState() => _MonthlyRecordWidgetState();
}

class _MonthlyRecordWidgetState extends State<MonthlyRecordWidget> {
  final ratecontroller = TextEditingController();

  double totalMilk = 0.0;

  @override
  Widget build(BuildContext context) {
    final recrodScreenProvier = Provider.of<RecordscreenViewModel>(context);
    totalMilk = 0.0;
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Alkhar_milk_point')
                .doc('Year')
                .collection(widget.year.toString())
                .doc(widget.month.toString())
                .collection('chkCollection')
                .doc(widget.chkName.toString())
                .collection("clients")
                .doc(widget.clientName.toString().toLowerCase())
                .collection('ClientRecord')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ));
              }
              if (snapshot.hasError) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 60),
                          child: ErrorDisplayWidget(error: "Check Internet"),
                        ),
                      ],
                    ));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 60),
                          child: ErrorDisplayWidget(error: "Record Not Found"),
                        ),
                      ],
                    ));
              }
              final documents = snapshot.data!.docs;
              for (var i = 0; i < snapshot.data!.docs.length; i++) {
                totalMilk = totalMilk + documents[i]['totalWieght'];
              }

              return Card(
                color: const Color.fromARGB(255, 185, 207, 243),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Monthly Record ${widget.year}",
                        style: AppTextStyles.black18Bold,
                      ),
                      Divider(
                        color: Colors.black.withOpacity(0.4),
                      ),
                      Row(
                        children: [
                          Text(
                            'Name of the Client: ',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.clientName.toString().toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Month Name: ',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.month,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Total Wieght: ',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${totalMilk.toString()} kg ' ?? "Processing",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Payable Amount:',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Consumer<RecordscreenViewModel>(
                    builder: (context, value, child) {
                      return Text("Rs ${value.payableAmount.toString()}");
                    },
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              priceTextField(
                  controller: ratecontroller,
                  hinttext: 'Enter Rate Here',
                  label: 'Rate'),
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Consumer(
                        builder: (context, value, child) {
                          // final parsedNumber = int.tryParse(ratecontroller.text);
                          return CustomButtonWidget(
                            btnWidth: 0.9,
                            btnColor: Colors.blueAccent,
                            title: 'Calculate',
                            ontap: () {
                              recrodScreenProvier.calculateAmount(
                                  totalMilk, ratecontroller.text.toString());
                            },
                          );
                        },
                      )),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class priceTextField extends StatefulWidget {
  TextEditingController controller;
  String label;
  String hinttext;
  int? minLines;
  priceTextField(
      {super.key,
      required this.controller,
      required this.hinttext,
      this.minLines = 1,
      required this.label});

  @override
  State<priceTextField> createState() => _priceTextFieldState();
}

class _priceTextFieldState extends State<priceTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      maxLines: 3,
      minLines: widget.minLines,
      keyboardType: const TextInputType.numberWithOptions(decimal: false),
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
