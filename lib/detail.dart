import 'package:flutter/material.dart';
import 'package:todolist/todolist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/todolist.dart';

class Detail extends StatefulWidget {
  final TaskPerson person;

  Detail(this.person);

  @override
  _DetailState createState() => _DetailState(this.person);
}

class _DetailState extends State<Detail> {
  TaskPerson person;

  _DetailState(this.person);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Task"),
      ),
      body: Column(children: <Widget>[
        Text(person.nama),
        Text(person.id),
        // RaisedButton(
        //   child: Text("Delete"),
        //   onPressed: () {
        //     deleteData,
        //     moveToLastScreen();
        //   },
        // ),
        //2. membuat form
      ]),
    );
  }

  // void moveToLastScreen(){
  //   Navigator.pop(context, true);
  // }

  // void createData() async {
  //   if (_formKey.currentState.validate()) {
  //     _formKey.currentState.save();
  //     DocumentReference ref = await db
  //         .collection('todolist')
  //         .add({'name': '$nama', 'task': '$tugas'});
  //     setState(() => id = ref.documentID);
  //     print(ref.documentID);
  //   }
  // }
  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void deleteData(DocumentSnapshot doc) async {
    await Firestore.instance
        .collection('todolist')
        .document(doc.documentID)
        .delete();
    setState(() {
      person.id = null;
    });
  }
}
