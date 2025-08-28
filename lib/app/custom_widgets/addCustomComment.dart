import 'package:flutter/material.dart';
import 'package:khata_app/app/custom_widgets/custom_button_widget.dart';
import 'package:khata_app/app/custom_widgets/custom_text_field_widget.dart';
import 'package:khata_app/app/res/app_text_styles.dart';
import 'package:khata_app/app/utils/notification_utils.dart';
import 'package:khata_app/app/view_model/recordScreen_view_model.dart';
import 'package:provider/provider.dart';

class AddCustomComment extends StatefulWidget {
  int year;
  String month;
  String chkName;
  int todayDate;
  String clientName;
  AddCustomComment(
      {super.key,
      required this.year,
      required this.month,
      required this.todayDate,
      required this.chkName,
      required this.clientName});

  @override
  State<AddCustomComment> createState() => _AddCustomCommentState();
}

class _AddCustomCommentState extends State<AddCustomComment> {
  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Add New Comment',
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
            CustomTextFieldWidget(
                minLines: 3,
                controller: commentController,
                hinttext: 'Enter Comments',
                label: 'Comments'),
            SizedBox(
              height: 20,
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
                    return value.addingComment
                        ? Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: CircularProgressIndicator(
                              color: Colors.blueAccent,
                            ),
                          )
                        : CustomButtonWidget(
                            btnColor: Colors.blueAccent,
                            title: 'Submit',
                            btnWidth: 0.35,
                            ontap: () {
                              commentController.text.toString().isEmpty
                                  ? NotificationUtils.customNotification(
                                      context,
                                      "Field Error",
                                      "Please Enter The Comment",
                                      false)
                                  : value.addComment(
                                      context,
                                      widget.year,
                                      widget.month,
                                      widget.chkName,
                                      widget.todayDate,
                                      widget.clientName,
                                      commentController.text.toString().trim());
                            },
                          );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
