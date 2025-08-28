import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khata_app/app/custom_widgets/error_display_widget.dart';

class CommentsListWidget extends StatefulWidget {
  String year;
  String month;
  String chkName;
  String clientName;
  CommentsListWidget(
      {super.key,
      required this.year,
      required this.month,
      required this.chkName,
      required this.clientName});

  @override
  State<CommentsListWidget> createState() => _CommentsListWidgetState();
}

class _CommentsListWidgetState extends State<CommentsListWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Alkhar_milk_point')
          .doc('Year')
          .collection(widget.year.toString())
          .doc(widget.month.toString())
          .collection('chkCollection')
          .doc(widget.chkName.toString())
          .collection("clients")
          .doc(widget.clientName.toString().toLowerCase())
          .collection('AdminComments')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              strokeWidth: 4,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ));
        }
        if (snapshot.hasError) {
          return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 60),
                    child: ErrorDisplayWidget(error: "Check Internet"),
                  ),
                ],
              ));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 60),
                    child: ErrorDisplayWidget(error: "Record Not Found"),
                  ),
                ],
              ));
        }
        final documents = snapshot.data!.docs;
        return Column(
          children: [
            Text(
              "Admin Comments",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    documents.length,
                    (index) {
                      return Card(
                        color: const Color.fromARGB(255, 185, 207, 243),
                        child: ListTile(
                          leading: Icon(Icons.multitrack_audio_outlined),
                          title: Row(
                            children: [
                              Text(
                                  textAlign: TextAlign.justify,
                                  documents[index]['commentsDate'].toString()),
                            ],
                          ),
                          subtitle:
                              Text(documents[index]['comments'].toString()),
                          trailing: PopupMenuButton(
                            // icon: Icon(Icons.arrow_drop_down),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                  onTap: () {
                                    FirebaseFirestore.instance
                                        .collection('Alkhar_milk_point')
                                        .doc('Year')
                                        .collection(widget.year.toString())
                                        .doc(widget.month.toString())
                                        .collection('chkCollection')
                                        .doc(widget.chkName.toString())
                                        .collection("clients")
                                        .doc(widget.clientName
                                            .toString()
                                            .toLowerCase())
                                        .collection('AdminComments')
                                        .doc(documents[index].id.toString())
                                        .delete();
                                  },
                                  child: Text("Delete")),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
