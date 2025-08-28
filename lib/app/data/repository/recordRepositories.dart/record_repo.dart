import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:khata_app/app/data/response/app_exception.dart';

class RecordRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  userRecordMorningRepo(int year, String month, String chkName, int todayDate,
      String clientName, String comments, dynamic data) async {
    try {
      print(
          "${year} ${month} ${chkName} ${todayDate} ${clientName} ${comments} ${data}");
      await _firestore
          .collection('Alkhar_milk_point')
          .doc('Year')
          .collection(year.toString().trim())
          .doc(month.toString().trim())
          .collection('chkCollection')
          .doc(chkName.toString().trim())
          .collection("clients")
          .doc(clientName.toString().toLowerCase().trim())
          .collection('ClientRecord')
          // .doc('5')
          .doc(todayDate.toString().trim())
          .set(
            data,
            SetOptions(merge: true),
          )
          .timeout(Duration(seconds: 10));

      if (comments.toString().isNotEmpty) {
        await _firestore
            .collection('Alkhar_milk_point')
            .doc('Year')
            .collection(year.toString().trim())
            .doc(month.toString().trim())
            .collection('chkCollection')
            .doc(chkName.toString().trim())
            .collection("clients")
            .doc(clientName.toString().toLowerCase().trim())
            // .collection('ClientRecord')
            // .doc('Comments')
            .collection('AdminComments')
            .doc(DateTime.now().microsecondsSinceEpoch.toString())
            .set(
                {'commentsDate': '${todayDate} ${month}', 'comments': comments})
            .timeout(Duration(seconds: 10))
            .onError(
              (error, stackTrace) {
                throw InternetException("Check Your Internet");
              },
            );
      }
    } on FirebaseException catch (_) {
      throw InternetException("Check your internet connection");
    } on SocketException catch (_) {
      throw InternetException("No internet connection");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  userRecordEveningRepo(int year, String month, String chkName, int todayDate,
      String clientName, String comments, dynamic data) async {
    try {
      await _firestore
          .collection('Alkhar_milk_point')
          .doc('Year')
          .collection(year.toString().trim())
          .doc(month.toString().trim())
          .collection('chkCollection')
          .doc(chkName.toString().trim())
          .collection("clients")
          .doc(clientName.toString().toLowerCase().trim())
          .collection('ClientRecord')
          .doc(todayDate.toString().trim())
          .set(
            data,
            SetOptions(merge: true),
          )
          .timeout(Duration(seconds: 10))
          .onError(
        (error, stackTrace) {
          throw InternetException("Check Your Internet");
        },
      );
      if (comments.toString().isNotEmpty) {
        await _firestore
            .collection('Alkhar_milk_point')
            .doc('Year')
            .collection(year.toString().trim())
            .doc(month.toString().trim())
            .collection('chkCollection')
            .doc(chkName.toString().trim())
            .collection("clients")
            .doc(clientName.toString().toLowerCase().trim())
            // .collection('ClientRecord')
            // .doc('Comments')
            .collection('AdminComments')
            .doc(DateTime.now().microsecondsSinceEpoch.toString())
            .set(
                {'commentsDate': '${todayDate} ${month}', 'comments': comments})
            .timeout(Duration(seconds: 10))
            .onError(
              (error, stackTrace) {
                throw InternetException("Check Your Internet");
              },
            );
      }
    } catch (e) {
      rethrow;
    }
  }

  addNewclientRepo(
    int year,
    String month,
    String chkName,
    String clientName,
  ) async {
    Map<String, dynamic> data = {
      'name': clientName.toString().toLowerCase().trim(),
      'createdAt': FieldValue.serverTimestamp(),
      'monthlyTotalMilk': 0.0
    };
    await _firestore
        .collection('Alkhar_milk_point')
        .doc('Year')
        .collection(year.toString().trim())
        .doc(month.toString().trim())
        .collection('chkCollection')
        .doc(chkName.toString().trim())
        .collection("clients")
        .doc(clientName.toString().toLowerCase().trim())
        .set(data)
        .timeout(Duration(seconds: 10))
        .onError(
      (error, stackTrace) {
        throw InternetException("Check Your Internet");
      },
    );
  }

  getMilkWieght(
    int year,
    String month,
    String chkName,
    int todayDate,
    String clientName,
  ) async {
    final record = await _firestore
        .collection('Alkhar_milk_point')
        .doc('Year')
        .collection(year.toString().trim())
        .doc(month.toString().trim())
        .collection('chkCollection')
        .doc(chkName.toString().trim())
        .collection("clients")
        .doc(clientName.toString().toLowerCase().trim())
        .collection('ClientRecord')
        .doc(todayDate.toString().trim())
        .get();
    return record.data();
  }

  //repo to update daily record
  updateTotalMilkrepo(int year, String month, String chkName, int todayDate,
      String clientName, dynamic data) async {
    await _firestore
        .collection('Alkhar_milk_point')
        .doc('Year')
        .collection(year.toString().trim())
        .doc(month.toString().trim())
        .collection('chkCollection')
        .doc(chkName.toString().trim())
        .collection("clients")
        .doc(clientName.toString().toLowerCase().trim())
        .collection('ClientRecord')
        .doc(todayDate.toString().trim())
        .set(
          data,
          SetOptions(merge: true),
        );
  }

  addNewCommment(int year, String month, String chkName, String clientName,
      int todayDate, String comments) async {
    await _firestore
        .collection('Alkhar_milk_point')
        .doc('Year')
        .collection(year.toString().trim())
        .doc(month.toString().trim())
        .collection('chkCollection')
        .doc(chkName.toString().trim())
        .collection("clients")
        .doc(clientName.toString().toLowerCase().trim())
        // .collection('ClientRecord')
        // .doc('Comments')
        .collection('AdminComments')
        .doc(DateTime.now().microsecondsSinceEpoch.toString())
        .set({'commentsDate': '${todayDate} ${month}', 'comments': comments})
        .timeout(Duration(seconds: 10))
        .onError(
          (error, stackTrace) {
            throw InternetException("Check Your Internet");
          },
        );
  }
}
