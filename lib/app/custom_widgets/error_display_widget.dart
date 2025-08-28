import 'package:flutter/material.dart';

class ErrorDisplayWidget extends StatelessWidget {
  String error;
  ErrorDisplayWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 70),
      child: Column(
        children: [
          Icon(
            Icons.cloud_off_outlined,
            color: const Color.fromARGB(255, 103, 102, 102),
          ),
          Text(
            error,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
