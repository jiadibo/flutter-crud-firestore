import 'package:flutter/material.dart';
import 'package:todolist/todolist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Detail extends StatefulWidget {
  final TaskPerson person;

  Detail(this.person);

  @override
  _DetailState createState() => _DetailState(this.person);
}

class _DetailState extends State<Detail> {
  TaskPerson person;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  _DetailState(this.person);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Task"),
      ),
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
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
                    initialValue: person.nama,
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
                    initialValue: person.tugas,
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
                        child: Text("Update"),
                        onPressed: () => updateData(person),
                      ),
                      RaisedButton(
                        child: Text("Delete"),
                        onPressed: () => deleteData(person),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateData(TaskPerson person) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      await Firestore.instance
          .collection('todolist')
          .document(person.id)
          .updateData({'name': person.nama, 'task': person.tugas}).whenComplete(
              () {
        print("Berhasil di update");
      });
      setState(() => person.nama = person.nama);
      print(person.nama);
    }
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void deleteData(TaskPerson person) async {
    await Firestore.instance
        .collection('todolist')
        .document(person.id)
        .delete();
    setState(() {
      person.id = null;
      print("data id = ${person.id}");
    });
  }
}
