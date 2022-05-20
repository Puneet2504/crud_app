import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_app/pages/edit_student_page.dart';
import 'package:flutter/material.dart';

class ListStudentPage extends StatefulWidget {
  const ListStudentPage({Key? key}) : super(key: key);

  @override
  State<ListStudentPage> createState() => _ListStudentPageState();
}

class _ListStudentPageState extends State<ListStudentPage> {
  final Stream<QuerySnapshot> studentStream =
      FirebaseFirestore.instance.collection('student').snapshots();

  CollectionReference students =
      FirebaseFirestore.instance.collection('student');
  Future<void> deleteUSer(id) {
    return students
        .doc(id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Falied to delete user"));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: studentStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  1: FixedColumnWidth(190),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(children: [
                    TableCell(
                        child: Container(
                      color: Colors.greenAccent,
                      child: Center(
                        child: Text(
                          "Name",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                    TableCell(
                        child: Container(
                      color: Colors.greenAccent,
                      child: Center(
                        child: Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                    TableCell(
                        child: Container(
                      color: Colors.greenAccent,
                      child: Center(
                        child: Text(
                          "Actions",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ))
                  ]),
                  for (var i = 0; i < storedocs.length; i++) ...[
                    TableRow(children: [
                      TableCell(
                        child: Center(
                          child: Text(
                            storedocs[i]['name'],
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            storedocs[i]['email'],
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditStudentPage(
                                              id: storedocs[i]['id'])));
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.orangeAccent,
                                )),
                            IconButton(
                                onPressed: () =>
                                    {deleteUSer(storedocs[i]['id'])},
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.orange,
                                ))
                          ],
                        )),
                      ),
                    ])
                  ]
                ],
              ),
            ),
          );
        });
  }
}
