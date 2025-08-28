import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khata_app/app/custom_widgets/customBottomSheet.dart';
import 'package:khata_app/app/custom_widgets/custom_app_bar.dart';
import 'package:khata_app/app/custom_widgets/custom_button_widget.dart';
import 'package:khata_app/app/custom_widgets/custom_text_field_widget.dart';
import 'package:khata_app/app/custom_widgets/deleteChkWidget.dart';
import 'package:khata_app/app/custom_widgets/error_display_widget.dart';
import 'package:khata_app/app/custom_widgets/month_widget.dart';
import 'package:khata_app/app/res/app_Strings.dart';
import 'package:khata_app/app/res/app_colors.dart';
import 'package:khata_app/app/utils/calender_utils.dart';
import 'package:khata_app/app/utils/notification_utils.dart';
import 'package:khata_app/app/view/record_screen.dart';
import 'package:khata_app/app/view_model/chk_view_model.dart';
import 'package:provider/provider.dart';

import '../res/app_text_styles.dart';

class ChkViewScreen extends StatefulWidget {
  int selectedYear;
  String selectedMonth;
  ChkViewScreen(
      {super.key, required this.selectedMonth, required this.selectedYear});

  @override
  State<ChkViewScreen> createState() => _ChkViewScreenState();
}

class _ChkViewScreenState extends State<ChkViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
          automaticallyImplyLeading: false,
          actions: [
            InkWell(
              onTap: widget.selectedYear != DateTime.now().year ||
                      widget.selectedMonth !=
                          CalenderUtils.getMonthName(DateTime.now().month)
                  ? () {
                      NotificationUtils.customNotification(
                          context,
                          'Year or month Mismatch',
                          'You are in year ${widget.selectedYear.toString()}',
                          false);
                    }
                  : () {
                      CustomBottomSheet.show(
                          height: 350,
                          context: context,
                          child: AddNewChk(
                            selectedYear: widget.selectedYear,
                            selectedMonth: widget.selectedMonth,
                          ));
                    },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text('Add New Chk',
                    style: AppTextStyles.customText(color: Colors.white)),
              ),
            )
          ],
          backgroundColor: AppColors.appBarColor,
          title: AppStrings.appName),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Select the chk',
                      style: AppTextStyles.black18Bold,
                    ),
                  ],
                ),
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Alkhar_milk_point')
                  .doc('Year')
                  .collection(widget.selectedYear.toString())
                  .doc(widget.selectedMonth)
                  .collection('chkCollection')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: AppColors.appBarColor,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Fetching Data',
                            style: AppTextStyles.customText(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 14),
                          ),
                        ],
                      )));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.warning_amber_outlined),
                          Text(
                            'No Data Found',
                            style: AppTextStyles.customText(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 14),
                          ),
                        ],
                      )));
                }
                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 120, left: 60),
                    child: ErrorDisplayWidget(error: "Internet Error"),
                  );
                }
                final documents = snapshot.data!.docs;
                return Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Wrap(
                        children: List.generate(
                          documents.length,
                          (index) {
                            // final doc = documents[index];
                            // final data = doc.data() as Map<String, dynamic>;
                            return Column(
                              children: [
                                MonthWidget(
                                  btnColor: AppColors.appBarColor,
                                  monthName: documents[index].id.toString(),
                                  onlongpress: () {
                                    CustomBottomSheet.show(
                                        height: 200,
                                        context: context,
                                        child: Deletechkwidget(
                                          isConfirm: false,
                                          ontap: () {
                                            Navigator.pop(context);
                                            CustomBottomSheet.show(
                                                height: 200,
                                                context: context,
                                                child: Deletechkwidget(
                                                  isConfirm: true,
                                                  ontap: () async {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            'Alkhar_milk_point')
                                                        .doc('Year')
                                                        .collection(widget
                                                            .selectedYear
                                                            .toString())
                                                        .doc(widget
                                                            .selectedMonth)
                                                        .collection(
                                                            'chkCollection')
                                                        .doc(documents[index]
                                                            .id
                                                            .toString())
                                                        .delete();
                                                    Navigator.pop(context);
                                                  },
                                                ));
                                          },
                                        ));
                                  },
                                  ontap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RecordScreen(
                                            month: widget.selectedMonth,
                                            year: widget.selectedYear,
                                            chkName:
                                                documents[index].id.toString(),
                                          ),
                                        ));
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AddNewChk extends StatefulWidget {
  int selectedYear;
  String selectedMonth;
  AddNewChk(
      {super.key, required this.selectedMonth, required this.selectedYear});

  @override
  State<AddNewChk> createState() => _AddNewChkState();
}

class _AddNewChkState extends State<AddNewChk> {
  final chkController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Text(
            "Add New Chk",
            style: AppTextStyles.customText(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          Divider(),
          SizedBox(
            height: 20,
          ),
          CustomTextFieldWidget(
              controller: chkController,
              hinttext: 'Enter The Chk',
              label: 'Chk Name'),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButtonWidget(
                btnWidth: 0.35,
                btnColor: Colors.black.withOpacity(0.2),
                title: 'Cancel',
                ontap: () {
                  Navigator.pop(context);
                },
              ),
              Consumer<ChkViewModel>(
                builder: (context, value, child) {
                  return value.addingchk
                      ? Padding(
                          padding: EdgeInsets.only(right: 40),
                          child: CircularProgressIndicator(
                            color: AppColors.appBarColor,
                          ),
                        )
                      : CustomButtonWidget(
                          btnWidth: 0.35,
                          btnColor: Colors.blueAccent,
                          title: 'Submit',
                          ontap: () async {
                            chkController.text.toString().isEmpty
                                ? NotificationUtils.customNotification(context,
                                    'Field Error', 'Enter Chk Name', false)
                                : await value
                                    .addChk(
                                        context,
                                        widget.selectedYear,
                                        widget.selectedMonth,
                                        chkController.text
                                            .toString()
                                            .replaceAll('/', '-')
                                            .trim()
                                            .toLowerCase())
                                    .then(
                                    (value) {
                                      Navigator.pop(context);
                                    },
                                  );
                            print(
                                '${widget.selectedMonth} ${widget.selectedYear} ${chkController.text.toString().replaceAll('/', '-').trim().toLowerCase()}');
                          },
                        );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
