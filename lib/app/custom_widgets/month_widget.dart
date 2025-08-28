import 'package:flutter/material.dart';
import 'package:khata_app/app/res/app_text_styles.dart';

class MonthWidget extends StatelessWidget {
  String monthName;
  VoidCallback ontap;
  VoidCallback? onlongpress;
  Color? btnColor;
  MonthWidget(
      {super.key,
      required this.monthName,
      required this.ontap,
      this.onlongpress,
      this.btnColor = const Color.fromARGB(255, 105, 182, 246)});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
          onLongPress: onlongpress,
          onTap: ontap,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: btnColor),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                monthName,
                style: AppTextStyles.customText(
                    fontWeight: FontWeight.w600, fontSize: 15),
              ),
            )),
          )),
    );
  }
}
