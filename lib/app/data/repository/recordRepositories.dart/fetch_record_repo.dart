import 'package:cloud_firestore/cloud_firestore.dart';

class FetchRecordRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  fetchClientsRepo(
    int year,
    String month,
    String chkName,
  )  {
    return _firestore
        .collection('Alkhar_milk_point')
        .doc('Year')
        .collection(year.toString())
        .doc(month.toString())
        .collection('chkCollection')
        .doc(chkName.toString().trim())
        .collection("clients")
        .snapshots();
  }
}
