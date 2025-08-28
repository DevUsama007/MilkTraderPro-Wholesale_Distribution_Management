import 'package:flutter/material.dart';
import 'package:khata_app/app/custom_widgets/text_container_widget.dart';

class ViewCommentsWidget extends StatefulWidget {
  VoidCallback ontap;
  ViewCommentsWidget({super.key, required this.ontap});

  @override
  State<ViewCommentsWidget> createState() => _ViewCommentsWidgetState();
}

class _ViewCommentsWidgetState extends State<ViewCommentsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextContainerWidget(
          txt: 'Comments',
          containerWidth: 140,
        ),
        InkWell(
          onTap: widget.ontap,
          child: TextContainerWidget(
            txt: "View Comments",
            containerWidth: 140,
            containerHeight: 100,
          ),
        ),
      ],
    );
  }
}
