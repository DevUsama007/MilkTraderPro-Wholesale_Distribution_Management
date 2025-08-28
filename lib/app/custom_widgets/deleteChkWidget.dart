import 'package:flutter/material.dart';
import 'package:khata_app/app/custom_widgets/custom_button_widget.dart';

class Deletechkwidget extends StatefulWidget {
  bool isConfirm;
  VoidCallback ontap;
  Deletechkwidget({super.key, required this.isConfirm, required this.ontap});

  @override
  State<Deletechkwidget> createState() => _DeletechkwidgetState();
}

class _DeletechkwidgetState extends State<Deletechkwidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          widget.isConfirm
              ? Text(
                  'Click to Delete?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              : Text(
                  'Do You Realy Want to Delete?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButtonWidget(
                  btnWidth: 0.35,
                  btnColor: Colors.black.withOpacity(0.4),
                  title: "Cancel",
                  ontap: () {
                    Navigator.pop(context);
                  },
                ),
                CustomButtonWidget(
                  btnWidth: 0.35,
                  btnColor: Colors.blue,
                  title: "Confirm",
                  ontap: widget.ontap,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
