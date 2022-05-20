import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({Key? key}) : super(key: key);

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>();

  var name = "";
  var email = "";
  var password = "";

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  clearText() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  CollectionReference students =
      FirebaseFirestore.instance.collection('student');
  Future<void> addUser() {
    return students
        .add({'name': name, 'email': email, 'password': password})
        .then((value) => print("User Added"))
        .catchError((error) => print("Falied to add user"));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add New Student",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(
                          labelText: "Name",
                          labelStyle: TextStyle(fontSize: 18),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.red, fontSize: 15)),
                      controller: nameController,
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
                      autofocus: false,
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(fontSize: 18),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.red, fontSize: 15)),
                      controller: emailController,
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
                      obscureText: true,
                      autofocus: false,
                      decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(fontSize: 18),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.red, fontSize: 15)),
                      controller: passwordController,
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
                                  name = nameController.text;
                                  email = emailController.text;
                                  password = passwordController.text;
                                  addUser();
                                  clearText();
                                  Navigator.pop(context);
                                });
                              }
                            }),
                            child: Text(
                              "Register",
                              style: TextStyle(fontSize: 18),
                            )),
                        ElevatedButton(
                            onPressed: (() {
                              clearText();
                            }),
                            child: Text(
                              "Reset",
                              style: TextStyle(fontSize: 18),
                            ))
                      ],
                    ),
                  )
                ],
              ))),
    );
  }
}
