import 'package:flutter/material.dart';
import 'package:khata_app/app/res/app_colors.dart';

class CustomTextFieldWidget extends StatefulWidget {
  TextEditingController controller;
  String label;
  String hinttext;
  int? minLines;
  CustomTextFieldWidget(
      {super.key,
      required this.controller,
      required this.hinttext,
      this.minLines = 1,
      required this.label});

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      
      controller: widget.controller,
      maxLines: 3,
      minLines: widget.minLines,
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
