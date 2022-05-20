import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditStudentPage extends StatefulWidget {
  const EditStudentPage({Key? key, required this.id}) : super(key: key);

  final String id;
  @override
  State<EditStudentPage> createState() => _EditStudentPageState();
}

class _EditStudentPageState extends State<EditStudentPage> {
  final _formKey = GlobalKey<FormState>();

  CollectionReference students =
      FirebaseFirestore.instance.collection('student');

  Future<void> updateUser(id, name, email, password) {
    return students
        .doc(id)
        .update({'name': name, 'email': email, 'password': password})
      ..then((value) => print("User Added"))
          .catchError((error) => print("Falied to add user"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Student",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Form(
          key: _formKey,
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection('student')
                  .doc(widget.id)
                  .get(),
              builder: (_, snapshot) {
                if (snapshot.hasError) {
                  print("Something went wrong");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var data = snapshot.data!.data();
                var name = data!['name'];
                var email = data['email'];
                var password = data['password'];
                return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            initialValue: name,
                            autofocus: false,
                            onChanged: (value) => name = value,
                            decoration: InputDecoration(
                                labelText: "Name",
                                labelStyle: TextStyle(fontSize: 18),
                                border: OutlineInputBorder(),
                                errorStyle:
                                    TextStyle(color: Colors.red, fontSize: 15)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Name";
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            initialValue: email,
                            autofocus: false,
                            onChanged: (value) => email = value,
                            decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle: TextStyle(fontSize: 18),
                                border: OutlineInputBorder(),
                                errorStyle:
                                    TextStyle(color: Colors.red, fontSize: 15)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Email";
                              } else if (!value.contains('@')) {
                                return 'Please Enter Valid Email';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            initialValue: password,
                            obscureText: true,
                            autofocus: false,
                            onChanged: (value) => password = value,
                            decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: TextStyle(fontSize: 18),
                                border: OutlineInputBorder(),
                                errorStyle:
                                    TextStyle(color: Colors.red, fontSize: 15)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Password";
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                  onPressed: (() {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        updateUser(
                                            widget.id, name, email, password);
                                        Navigator.pop(context);
                                      });
                                    }
                                  }),
                                  child: Text(
                                    "Update",
                                    style: TextStyle(fontSize: 18),
                                  )),
                              ElevatedButton(
                                  onPressed: (() {}),
                                  child: Text(
                                    "Reset",
                                    style: TextStyle(fontSize: 18),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ));
              })),
    );
  }
}
