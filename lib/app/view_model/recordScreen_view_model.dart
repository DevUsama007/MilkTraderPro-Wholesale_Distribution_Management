import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khata_app/app/data/repository/recordRepositories.dart/record_repo.dart';
import 'package:khata_app/app/data/response/app_exception.dart';
import 'package:khata_app/app/utils/check_internetConection.dart';
import 'package:khata_app/app/utils/notification_utils.dart';

class RecordscreenViewModel extends ChangeNotifier {
  final recordRepo = RecordRepo();
  bool _addingRecord = false;
  bool _addingclient = false;
  String _milkTime = 'Morning';
  bool _addingComment = false;
  String get milkTime => _milkTime;
  bool get addingRecord => _addingRecord;
  bool get addingclient => _addingclient;
  double _payableAmount = 0.0;
  double get payableAmount => _payableAmount;
  bool get addingComment => _addingComment;

  calculateAmount(double wieght, String rate) {
    _payableAmount = 0.0;
    final parsedNumber = int.tryParse(rate);
    _payableAmount = (parsedNumber! * wieght)!;
    notifyListeners();
  }

  updateAddingComment(bool adding) {
    _addingComment = adding;
    notifyListeners();
  }

  updateAddingRecrod(bool adding) {
    _addingRecord = adding;
    notifyListeners();
  }

  resetPayableAmount() {
    _payableAmount = 0.0;
    notifyListeners();
  }

  updateAddingclient(bool adding) {
    _addingclient = adding;
    notifyListeners();
  }

  updateMilkTime(String milktime) {
    _milkTime = milktime;
    notifyListeners();
  }

  Future addComment(BuildContext context, int year, String month,
      String chkName, int todayDate, String clientName, String comments) async {
    final isConnected = await CheckInternetconection.checkInternetConnection();
    if (!isConnected) {
      NotificationUtils.customNotification(
          context, "Failed", "Check Your Internet Connection", false);
    } else {
      updateAddingComment(true);
      try {
        await recordRepo.addNewCommment(
            year, month, chkName, clientName, todayDate, comments);
        updateAddingComment(false);
        NotificationUtils.customNotification(
            context, "Success", "Record Insertion Success", true);
        Navigator.pop(context);
      } on InternetException catch (e) {
        print("Internet error: ${e}");
        NotificationUtils.customNotification(
            context, "Failed", "Comment Insertion Failed", false);
        updateAddingRecrod(false);
      } catch (e) {
        NotificationUtils.customNotification(
            context, "Failed", "Comment Insertion Failed", false);
        updateAddingRecrod(false);
      }
    }
  }

  Future<void> addRecordMorning(
      BuildContext context,
      dynamic data,
      int year,
      String month,
      String chkName,
      int todayDate,
      String clientName,
      String comments) async {
    final isConnected = await CheckInternetconection.checkInternetConnection();
    if (!isConnected) {
      NotificationUtils.customNotification(
          context, "Failed", "Check Your Internet Connection", false);
    } else {
      try {
        updateAddingRecrod(true);
        await recordRepo.userRecordMorningRepo(
            year, month, chkName, todayDate, clientName, comments, data);
        final milkData = await recordRepo.getMilkWieght(
            year, month, chkName, todayDate, clientName);
        if (milkData != null) {
          updateTotalMilk(year, month, chkName, todayDate, clientName,
              milkData['morningMilk'] ?? 0.0, milkData['eveningMilk'] ?? 0.0);
        } else {
          print('No record found');
        }
        updateAddingRecrod(false);
        // updateMonthlyTotalMillkClient(
        //     year, month, chkName, clientName, todayDate);
        NotificationUtils.customNotification(
            context, "Success", "Record Insertion Success", true);
      } on InternetException catch (e) {
        print("Internet error: ${e}");
        NotificationUtils.customNotification(
            context, "Failed", "Record Insertion Failed", false);
        updateAddingRecrod(false);
      } catch (e) {
        NotificationUtils.customNotification(
            context, "Failed", "Record Insertion Failed", false);
        updateAddingRecrod(false);
      }
    }
  }

  Future<void> addRecordEvening(
      BuildContext context,
      dynamic data,
      int year,
      String month,
      String chkName,
      int todayDate,
      String clientName,
      String comments) async {
    final isConnected = await CheckInternetconection.checkInternetConnection();
    if (!isConnected) {
      NotificationUtils.customNotification(
          context, "Failed", "Check Your Internet Connection", false);
    } else {
      try {
        updateAddingRecrod(true);
        await recordRepo.userRecordEveningRepo(
            year, month, chkName, todayDate, clientName, comments, data);
        final milkData = await recordRepo.getMilkWieght(
            year, month, chkName, todayDate, clientName);
        if (milkData != null) {
          updateTotalMilk(year, month, chkName, todayDate, clientName,
              milkData['morningMilk'] ?? 0.0, milkData['eveningMilk'] ?? 0.0);
        } else {
          print('No record found');
        }
        updateAddingRecrod(false);
        // updateMonthlyTotalMillkClient(
        //     year, month, chkName, clientName, todayDate);
        NotificationUtils.customNotification(
            context, "Success", "Record Insertion Success", true);
      } on InternetException catch (e) {
        print("Internet error: ${e}");
        NotificationUtils.customNotification(
            context, "Failed", "Record Insertion Failed", false);
        updateAddingRecrod(false);
      } catch (e) {
        NotificationUtils.customNotification(
            context, "Failed", "Record Insertion Failed", false);
        updateAddingRecrod(false);
      }
    }
  }

  addNewClient(int year, String month, String chkName, String clientName,
      BuildContext context) async {
    updateAddingclient(true);
    try {
      await recordRepo
          .addNewclientRepo(year, month, chkName, clientName)
          .then((_) {
        updateAddingclient(false);
        NotificationUtils.customNotification(
            context, "Success", "Client Added Successfuly", true);
        Navigator.pop(context);
        print("chk inserted!");
      }).catchError((e) {
        print(e.toString());
        updateAddingclient(false);
        NotificationUtils.customNotification(
            context, "Success", "Client Added Successfuly", true);
      });
    } catch (e) {
      NotificationUtils.customNotification(
          context, "Failed", "Client Insertion Failed", false);
      updateAddingclient(false);
    }
  }

  Future updateTotalMilk(int year, String month, String chkName, int todayDate,
      String clientName, double morningMilk, double eveningMilk) async {
    double totalMilk = morningMilk + eveningMilk;
    Map<String, dynamic> data = {
      'totalWieght': totalMilk,
    };
    print(data);
    await recordRepo.updateTotalMilkrepo(
        year, month, chkName, todayDate, clientName, data);
  }
}
