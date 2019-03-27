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
            return InkWell(
              onTap: () => viewDetail(context, listPerson[index]),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  margin: EdgeInsets.all(2.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.person),
                        title:  Text(
                        listPerson[index].nama,
                        style: TextStyle(fontSize: 24),
                        
                      ),
                      subtitle: Text(listPerson[index].tugas),
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
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTask(),
            ),
          );
        },
      ),
    );
  }

  void viewDetail(BuildContext context, TaskPerson person) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Detail(person)));
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

  void deleteData(DocumentSnapshot doc, TaskPerson person) async {
    await Firestore.instance.collection('CRUD').document(person.id).delete();
    setState(() => person.id = null);
  }
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
