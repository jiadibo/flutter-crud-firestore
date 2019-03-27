import 'package:flutter/material.dart';
import 'package:todolist/todolist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var person = TaskPerson();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("Add task"),
      ),
      body: Container(
        child: Card(
          margin: EdgeInsets.all(10.0),
          child: Padding(
            padding: EdgeInsets.all(8),
                      child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Nama',
                      fillColor: Colors.grey[100],
                      filled: true,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                    },
                    onSaved: (value) => person.nama = value,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Tugas',
                      fillColor: Colors.grey[100],
                      filled: true,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                    },
                    onSaved: (value) => person.tugas = value,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.blue,
                        child: Text(
                          "Create",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          createData();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void createData() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DocumentReference ref = await Firestore.instance
          .collection('todolist')
          .add({'name': person.nama, 'task': person.tugas});
      setState(() => person.id = ref.documentID);
      print(ref.documentID);
      moveToLastScreen();
    }
  }
}
