import 'package:flutter/material.dart';
import 'package:khata_app/app/custom_widgets/text_container_widget.dart';

class MilkRecordWidget extends StatefulWidget {
  String date;
  double morningMilk;
  double eveningMilk;
  double totalMilk;
  MilkRecordWidget(
      {super.key,
      required this.date,
      required this.morningMilk,
      required this.eveningMilk,
      required this.totalMilk});

  @override
  State<MilkRecordWidget> createState() => _MilkRecordWidgetState();
}

class _MilkRecordWidgetState extends State<MilkRecordWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextContainerWidget(
          txt: widget.date,
          containerWidth: 140,
        ),
        Row(
          children: [
            TextContainerWidget(
              containerWidth: 70,
              txt: 'M:\n${widget.morningMilk} kg'.toString(),
            ),
            TextContainerWidget(
              txt: 'E:\n${widget.eveningMilk} kg'.toString(),
              containerWidth: 70,
            ),
          ],
        ),
        TextContainerWidget(
          txt: "${widget.totalMilk} kg".toString(),
          containerWidth: 140,
        ),
      ],
    );
  }
}
