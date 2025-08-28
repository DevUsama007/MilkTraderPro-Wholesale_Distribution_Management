import 'package:flutter/material.dart';
import 'package:khata_app/app/custom_widgets/text_container_widget.dart';

class NameRecordWidget extends StatefulWidget {
  String name;
  VoidCallback ontap;

  VoidCallback? onlongpress;
  String title;
  NameRecordWidget(
      {super.key,
      required this.name,
      required this.ontap,
      this.onlongpress,
      this.title = 'Name'});

  @override
  State<NameRecordWidget> createState() => _NameRecordWidgetState();
}

class _NameRecordWidgetState extends State<NameRecordWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextContainerWidget(
          txt: widget.title.toString(),
          containerWidth: 140,
        ),
        InkWell(
          onLongPress: widget.onlongpress,
          onTap: widget.ontap,
          child: TextContainerWidget(
            txt: widget.name,
            containerWidth: 140,
            containerHeight: 100,
          ),
        ),
      ],
    );
  }
}
