import 'package:flutter/material.dart';
import 'package:todolist/todolist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/todolist.dart';

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
      appBar: AppBar(
        title: Text("Add task"),
      ),
      body: Column(
        children: <Widget>[
          //2. membuat form
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'name',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                  onSaved: (value) => person.nama = value,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'name',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                  onSaved: (value) => person.tugas = value,
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              RaisedButton(
                child: Text("Create"),
                onPressed: () {
                  createData();
                  moveToLastScreen();
                },
              ),
              RaisedButton(
                child: Text("Delete"),
                onPressed: () {},
              ),
            ],
          ),
        ],
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
    }
  }

//  void deleteData(DocumentSnapshot doc) async {
//   await Firestore.instance.collection('todolist').document(doc.documentID).delete();
//   setState(() {
//     id = null;
//   });
// }
}
