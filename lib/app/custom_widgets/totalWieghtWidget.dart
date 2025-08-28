import 'package:flutter/material.dart';
import 'package:khata_app/app/custom_widgets/text_container_widget.dart';

class Totalwieghtwidget extends StatefulWidget {
  double totalWieght;
  Totalwieghtwidget({super.key, required this.totalWieght});

  @override
  State<Totalwieghtwidget> createState() => _TotalwieghtwidgetState();
}

class _TotalwieghtwidgetState extends State<Totalwieghtwidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextContainerWidget(
          txt: 'Total(Weight)',
          containerWidth: 140,
        ),
        TextContainerWidget(
          txt: "${widget.totalWieght} kg".toString(),
          containerWidth: 140,
          containerHeight: 100,
        ),
      ],
    );
  }
}
