import 'package:flutter/material.dart'; //import package firestore
import 'package:todolist/detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/add_task.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  var listPerson = List<TaskPerson>();

  @override
  void initState() {
    super.initState();
    loadTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To do List"),
      ),
      body: ListView.builder(
        itemCount: listPerson.length,
        itemBuilder: (context, index) {
          if (listPerson == null) {
            return Text("Loading");
          } else {
            return Container(
              child: InkWell(
                onTap: () => viewDetail(context, listPerson[index]),
                child: Card(
                  margin: EdgeInsets.all(2.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        listPerson[index].nama,
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(listPerson[index].tugas),
                      RaisedButton(
                        child: Text("Delete"),
                        onPressed: (){
                          
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTask()));
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => Detail("Tambah Task")));
        },
      ),
    );
  }

  void loadTask() {
    Firestore.instance.collection('todolist').snapshots().listen((value) {
      List<TaskPerson> taskPerson =
          value.documents.map((doc) => TaskPerson.fromDocument(doc)).toList();
      setState(() {
        listPerson = taskPerson;
        print("Banyak task : ${listPerson.length}");
        listPerson.forEach((taskP) => print("${taskP.nama}"));
      });
    });
  }

  void viewDetail(BuildContext context, TaskPerson person) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Detail(person)));
  }

  // void deleteData(DocumentSnapshot doc, TaskPerson person) async {
  //   await Firestore.instance
  //       .collection('CRUD')
  //       .document(doc.documentID)
  //       .delete();
  //   setState(() => person.id = null);
  // }
}

class TaskPerson {
  var id;
  var nama;
  var tugas;

  static TaskPerson fromDocument(DocumentSnapshot doc) {
    TaskPerson taskP = TaskPerson();
    taskP.id = doc.documentID;
    taskP.nama = doc.data["name"];
    taskP.tugas = doc.data["task"];

    return taskP;
  }
}
