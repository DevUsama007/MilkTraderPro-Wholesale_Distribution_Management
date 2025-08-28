import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:khata_app/app/custom_widgets/addCustomComment.dart';
import 'package:khata_app/app/custom_widgets/addNewRecordWidget.dart';
import 'package:khata_app/app/custom_widgets/comments_list_widget.dart';
import 'package:khata_app/app/custom_widgets/customBottomSheet.dart';
import 'package:khata_app/app/custom_widgets/customRecordAddWidget.dart';
import 'package:khata_app/app/custom_widgets/custom_app_bar.dart';
import 'package:khata_app/app/custom_widgets/custom_text_field_widget.dart';
import 'package:khata_app/app/custom_widgets/deleteChkWidget.dart';
import 'package:khata_app/app/custom_widgets/editRecordWidget.dart';
import 'package:khata_app/app/custom_widgets/error_display_widget.dart';
import 'package:khata_app/app/custom_widgets/milk_record_widget.dart';
import 'package:khata_app/app/custom_widgets/monthly_record_widget.dart';
import 'package:khata_app/app/custom_widgets/nameRecordWidget.dart';
import 'package:khata_app/app/custom_widgets/text_container_widget.dart';
import 'package:khata_app/app/custom_widgets/totalWieghtWidget.dart';
import 'package:khata_app/app/custom_widgets/viewCommentsWidget.dart';
import 'package:khata_app/app/data/repository/recordRepositories.dart/fetch_record_repo.dart';
import 'package:khata_app/app/res/app_colors.dart';
import 'package:khata_app/app/res/app_text_styles.dart';
import 'package:khata_app/app/utils/calender_utils.dart';
import 'package:khata_app/app/utils/notification_utils.dart';
import 'package:khata_app/app/view_model/recordScreen_view_model.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/custom_button_widget.dart';

class RecordScreen extends StatefulWidget {
  int year;
  String month;
  String chkName;

  RecordScreen(
      {super.key,
      required this.month,
      required this.year,
      required this.chkName});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  final FetchRecordRepo _fetchRecordRepo = FetchRecordRepo();
  @override
  Widget build(BuildContext context) {
    final recordScreenProvider = Provider.of<RecordscreenViewModel>(context);
    return Scaffold(
      appBar: CustomAppbar(
          automaticallyImplyLeading: false,
          actions: [
            InkWell(
              onTap: widget.year != DateTime.now().year ||
                      widget.month !=
                          CalenderUtils.getMonthName(DateTime.now().month)
                  ? () {
                      NotificationUtils.customNotification(
                          context,
                          'Year or month Mismatch',
                          'You are in year ${widget.year.toString()}',
                          false);
                    }
                  : () {
                      CustomBottomSheet.show(
                          height: 250,
                          context: context,
                          child: AddNewClient(
                            year: widget.year,
                            month: widget.month,
                            chkName: widget.chkName,
                          ));
                    },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Add New Client',
                  style: AppTextStyles.small10,
                ),
              ),
            )
          ],
          centerTitle: false,
          backgroundColor: AppColors.appBarColor,
          title: "${widget.month} ${widget.year} '${widget.chkName}' "),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Alkhar_milk_point')
                      .doc('Year')
                      .collection(widget.year.toString())
                      .doc(widget.month.toString())
                      .collection('chkCollection')
                      .doc(widget.chkName.toString().trim())
                      .collection("clients")
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
                    if (snapshot.hasError) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 120, left: 60),
                        child: ErrorDisplayWidget(error: "Internet Error"),
                      );
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 120, left: 60),
                        child: ErrorDisplayWidget(error: "No Recrods"),
                      );
                    }
                    final documents = snapshot.data!.docs;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        documents.length,
                        (index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  NameRecordWidget(
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
                                                              .year
                                                              .toString())
                                                          .doc(widget.month
                                                              .toString())
                                                          .collection(
                                                              'chkCollection')
                                                          .doc(widget.chkName
                                                              .toString()
                                                              .trim())
                                                          .collection("clients")
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
                                    name: documents[index].id.toString(),
                                    ontap: widget.year != DateTime.now().year ||
                                            widget.month !=
                                                CalenderUtils.getMonthName(
                                                    DateTime.now().month)
                                        ? () {
                                            NotificationUtils.customNotification(
                                                context,
                                                'Year or month Mismatch',
                                                'You are in year ${widget.year.toString()}',
                                                false);
                                          }
                                        : () {
                                            CustomBottomSheet.show(
                                                context: context,
                                                child: AddNewRecordWidget(
                                                  year: widget.year,
                                                  // year: 2055,
                                                  chkName: widget.chkName,
                                                  month: widget.month,
                                                  todayDate: DateTime.now().day,
                                                  clientName: documents[index]
                                                      .id
                                                      .toString()
                                                      .toLowerCase()
                                                      .trim(),
                                                ));
                                          },
                                  ),
                                  StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('Alkhar_milk_point')
                                        .doc('Year')
                                        .collection(widget.year.toString())
                                        .doc(widget.month.toString())
                                        .collection('chkCollection')
                                        .doc(widget.chkName.toString())
                                        .collection("clients")
                                        .doc(documents[index].id.toLowerCase())
                                        .collection('ClientRecord')
                                        .snapshots(),
                                    builder: (
                                      context,
                                      snapshot,
                                    ) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }

                                      if (snapshot.hasError) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              top: 120, left: 60),
                                          child: ErrorDisplayWidget(
                                              error: "Internet Error"),
                                        );
                                      }

                                      if (!snapshot.hasData ||
                                          snapshot.data!.docs.isEmpty) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            right: 130,
                                          ),
                                          child: ErrorDisplayWidget(
                                              error: "No Records"),
                                        );
                                      }

                                      final clients = snapshot.data!.docs;
                                      return Row(
                                        children: List.generate(
                                          clients.length,
                                          (innerIndex) {
                                            final docData = clients[innerIndex]
                                                .data() as Map<String, dynamic>;
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditRecordWidget(
                                                        year: widget.year,
                                                        chkName: widget.chkName,
                                                        month: widget.month,
                                                        todayDate: int.tryParse(
                                                                clients[innerIndex]
                                                                    .id
                                                                    .toString()) ??
                                                            0,
                                                        clientName:
                                                            documents[index]
                                                                .id
                                                                .toString()
                                                                .toLowerCase()
                                                                .trim(),
                                                      ),
                                                    ));
                                              },
                                              child: MilkRecordWidget(
                                                date: docData['date']
                                                        ?.toString() ??
                                                    'No Date', // Handle null date
                                                morningMilk:
                                                    (docData['morningMilk']
                                                                as num?)
                                                            ?.toDouble() ??
                                                        0.0,
                                                eveningMilk:
                                                    (docData['eveningMilk']
                                                                as num?)
                                                            ?.toDouble() ??
                                                        0.0,
                                                totalMilk:
                                                    (docData['totalWieght']
                                                                as num?)
                                                            ?.toDouble() ??
                                                        0.0,
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  NameRecordWidget(
                                    name: "View Comments",
                                    title: 'Comments',
                                    ontap: () {
                                      recordScreenProvider.resetPayableAmount();
                                      CustomBottomSheet.show(
                                          // height: 400,
                                          context: context,
                                          child: CommentsListWidget(
                                              year: widget.year.toString(),
                                              month: widget.month.toString(),
                                              chkName:
                                                  widget.chkName.toString(),
                                              clientName: documents[index]
                                                  .id
                                                  .toString()));
                                    },
                                  ),
                                  Card(
                                    child: Container(
                                      height: 90,
                                      width: 75,
                                      margin:
                                          EdgeInsets.only(top: 55, right: 10),
                                      // alignment: Alignment.center,
                                      child: DropdownButton<String>(
                                        // hint: Padding(
                                        //   padding:
                                        //       const EdgeInsets.only(left: 20),
                                        //   child: Text('More Options'),
                                        // ),
                                        hint: null,
                                        disabledHint: null,
                                        icon: Icon(
                                          Icons.more_vert,
                                          size: 30,
                                        ),
                                        underline:
                                            Container(), // Remove the default underline
                                        isExpanded: true,
                                        items: [
                                          DropdownMenuItem(
                                            value: 'view',
                                            child: Card(
                                              child: Container(
                                                margin: EdgeInsets.all(4),
                                                // Set your desired dropdown menu width
                                                child: Text(
                                                  textAlign: TextAlign.center,
                                                  "View Total Record",
                                                  style:
                                                      TextStyle(fontSize: 11),
                                                ),
                                              ),
                                            ),
                                          ),
                                          DropdownMenuItem(
                                            value: 'customrecord',
                                            child: Card(
                                              child: Container(
                                                // Same width for consistency
                                                margin: EdgeInsets.all(4),
                                                child: Text(
                                                  textAlign: TextAlign.center,
                                                  "Add Custom Record",
                                                  style:
                                                      TextStyle(fontSize: 11),
                                                ),
                                              ),
                                            ),
                                          ),
                                          DropdownMenuItem(
                                            value: 'customcomment',
                                            child: Card(
                                              child: Container(
                                                // Same width for consistency
                                                margin: EdgeInsets.all(4),
                                                child: Text(
                                                  textAlign: TextAlign.center,
                                                  "Add Comment",
                                                  style:
                                                      TextStyle(fontSize: 11),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                        onChanged: (value) {
                                          if (value == 'view') {
                                            CustomBottomSheet.show(
                                              context: context,
                                              child: MonthlyRecordWidget(
                                                year: widget.year.toString(),
                                                month: widget.month.toString(),
                                                chkName:
                                                    widget.chkName.toString(),
                                                clientName: documents[index]
                                                    .id
                                                    .toString(),
                                              ),
                                            );
                                          } else if (value == 'customcomment') {
                                            CustomBottomSheet.show(
                                                height: 700,
                                                context: context,
                                                child: AddCustomComment(
                                                    year: widget.year,
                                                    month: widget.month,
                                                    todayDate:
                                                        DateTime.now().day,
                                                    chkName: widget.chkName,
                                                    clientName: documents[index]
                                                        .id
                                                        .toString()));
                                          } else {
                                            CustomBottomSheet.show(
                                                height: 500,
                                                context: context,
                                                child: Customrecordaddwidget(
                                                    year: widget.year,
                                                    month: widget.month,
                                                    chkName: widget.chkName,
                                                    clientName: documents[index]
                                                        .id
                                                        .toString()));
                                          }
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddNewClient extends StatefulWidget {
  int year;
  String month;
  String chkName;
  AddNewClient(
      {super.key,
      required this.year,
      required this.month,
      required this.chkName});

  @override
  State<AddNewClient> createState() => _AddNewClientState();
}

class _AddNewClientState extends State<AddNewClient> {
  final clientController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Text("Add New Client"),
          SizedBox(
            height: 20,
          ),
          CustomTextFieldWidget(
              controller: clientController,
              hinttext: 'Enter The Client',
              label: 'Client Name'),
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
              Consumer<RecordscreenViewModel>(
                builder: (context, value, child) {
                  return value.addingclient
                      ? Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: CircularProgressIndicator(
                            color: AppColors.appBarColor,
                          ),
                        )
                      : CustomButtonWidget(
                          btnWidth: 0.35,
                          btnColor: Colors.blueAccent,
                          title: 'Submit',
                          ontap: () async {
                            clientController.text.toString().isEmpty
                                ? NotificationUtils.customNotification(context,
                                    "Field Error", "Enter The Name", false)
                                : await value.addNewClient(
                                    widget.year,
                                    widget.month,
                                    widget.chkName,
                                    clientController.text.toString().trim(),
                                    context);
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
