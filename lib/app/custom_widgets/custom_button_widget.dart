import 'package:flutter/material.dart';
import 'package:khata_app/app/res/app_colors.dart';
import 'package:khata_app/app/res/app_text_styles.dart';

class CustomButtonWidget extends StatefulWidget {
  double btnWidth;
  String title;
  VoidCallback ontap;
  Color btnColor;
  CustomButtonWidget(
      {super.key,
      required this.btnColor,
      required this.title,
      required this.ontap,
      this.btnWidth = 0.5});

  @override
  State<CustomButtonWidget> createState() => _CustomButtonWidgetState();
}

class _CustomButtonWidgetState extends State<CustomButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Container(
        width: MediaQuery.of(context).size.width * widget.btnWidth,
        height: 50,
        decoration: BoxDecoration(
            color: widget.btnColor, borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: Text(
          widget.title,
          style: AppTextStyles.regular12,
        )),
      ),
    );
  }
}
