import 'package:crud_app/pages/add_student_page.dart';
import 'package:crud_app/pages/list_student_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          "CRUD APP",
          style: TextStyle(fontSize: 20),
        ),
        IconButton(
            icon: Icon(Icons.add_box_rounded, size: 20),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddStudentPage()));
            }),
      ])),
      body: ListStudentPage(),
    );
  }
}
