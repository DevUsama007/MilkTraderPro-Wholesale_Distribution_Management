import 'package:flutter/material.dart';
import 'package:khata_app/app/utils/calender_utils.dart';

class TextContainerWidget extends StatelessWidget {
  String txt;
  double? containerWidth;
  double? containerHeight;
  TextContainerWidget(
      {super.key,
      required this.txt,
      this.containerWidth = 60,
      this.containerHeight = 50});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHeight,
      width: containerWidth,
      decoration: BoxDecoration(
          color: containerHeight == 50.0 &&
                  containerWidth == 140 &&
                  CalenderUtils.containsAlphabet(txt)
              ? const Color.fromARGB(255, 185, 207, 243)
              : Colors.white,
          border: Border.all(color: Colors.black)),
      child: Center(
          child: Text(
        txt.toString(),
        style: containerHeight == 100.0 && containerWidth == 140
            ? TextStyle(fontWeight: FontWeight.bold)
            : TextStyle(fontWeight: FontWeight.w400),
        maxLines: 2,
      )),
    );
  }
}
