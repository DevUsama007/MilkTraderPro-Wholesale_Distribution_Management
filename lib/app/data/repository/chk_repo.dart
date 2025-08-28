import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:khata_app/app/data/response/app_exception.dart';

class ChkRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  addChkName(int year, String month, String chkName) async {
    try {
      await _firestore
          .collection('Alkhar_milk_point')
          .doc('Year')
          .collection(year.toString().trim())
          .doc(month.toString().trim())
          .collection('chkCollection')
          .doc(chkName.toString().trim())
          .set({
            'name': chkName.toString().trim(),
            'createdAt': FieldValue.serverTimestamp(),
          })
          .timeout(Duration(seconds: 10))
          .onError(
            (error, stackTrace) {
              throw InternetException("Check Your Internet");
            },
          );
    } catch (e) {
      rethrow;
    }
  }
}
