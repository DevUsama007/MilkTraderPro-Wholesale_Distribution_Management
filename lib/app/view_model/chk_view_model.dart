import 'dart:io';

import 'package:flutter/material.dart';
import 'package:khata_app/app/data/repository/chk_repo.dart';
import 'package:khata_app/app/utils/notification_utils.dart';

class ChkViewModel extends ChangeNotifier {
  bool _addingChk = false;
  bool get addingchk => _addingChk;

  final chkRepo = ChkRepo();

  addingChk(bool value) {
    _addingChk = value;
    notifyListeners();
  }

  Future<void> addChk(
      BuildContext context, int year, String month, String chkName) async {
    // Check internet connectivity first (optional)
    final isConnected = await checkInternetConnection();
    if (!isConnected) {
      // throw Exception("No internet connection");
      NotificationUtils.customNotification(
          context, 'Error', 'Check Your Internet Connection', false);
      print("---------------------------------------------");
    } else {
      addingChk(true);
      await chkRepo.addChkName(year, month, chkName).then((_) {
        addingChk(false);
        print("chk inserted!");
        Navigator.pop(context);
      }).catchError((e) {
        addingChk(false);
        print("Failed to insert: $e");
      });
    }

    await chkRepo.addChkName(year, month, chkName).then((_) {
      addingChk(false);
      print("chk inserted!");
    }).catchError((e) {
      addingChk(false);
      print("Failed to insert: $e");
    });
  }

  // helper function to check the internet
  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
