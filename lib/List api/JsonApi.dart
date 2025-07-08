import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class JsonListUsers extends StatefulWidget {
  const JsonListUsers({super.key});

  @override
  State<JsonListUsers> createState() => _JsonListUsersState();
}

class _JsonListUsersState extends State<JsonListUsers> {
  Map<String,dynamic> bodyData={};
  List myTodos=[];
  Future<TodoClass> getTodoDetails() async{
    try {
      var apiResponse = await http.get(
          Uri.parse("https://dummyjson.com/todos"));
      bodyData = jsonDecode(apiResponse.body);
      print(bodyData);

      if (apiResponse.statusCode == 200 || apiResponse == 201) {
        myTodos=bodyData["todos"];
        return TodoClass.fromJson(bodyData);

      }
      else {
        throw Exception("Failed to load data");
      }
    }
    catch(e){
      print(e);
      throw Exception(e);
    }

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Todo List"),
        ),
      body:  FutureBuilder(future: getTodoDetails(), builder: (context,snapshot){
    if(snapshot.connectionState==ConnectionState.waiting)
    {
    return CircularProgressIndicator();
    }
    else if(snapshot.hasError)
    {
    return Text("Error:${snapshot.error}");
    }
    else if(snapshot.hasData)
    {
    var mydata=snapshot.data!;
    List todoList=mydata.todos as List;
       return ListView.builder(
      itemCount: myTodos.length,
        itemBuilder: (context,index){
          return  ListTile(
             title: Text(myTodos[index]["id"].toString()),
             subtitle: Column(
               children: [
                 Text(myTodos[index]["todo"]),
                 Text(myTodos[index]["completed"].toString()),
                 Text(myTodos[index]["userId"].toString()),
                 Text(bodyData["total"].toString()),
                 Text(bodyData["skip"].toString()),
                 Text(bodyData["limit"].toString()),
               ],
             ),
           );
        });
    }
    else
    {
    return Text("No data found");
    }
    })
    );
  }
}


class TodoClass {
  List<Todos>? todos;
  int? total;
  int? skip;
  int? limit;

  TodoClass({this.todos, this.total, this.skip, this.limit});

  TodoClass.fromJson(Map<String, dynamic> json) {
    if (json['todos'] != null) {
      todos = <Todos>[];
      json['todos'].forEach((v) {
        todos!.add(new Todos.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.todos != null) {
      data['todos'] = this.todos!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['skip'] = this.skip;
    data['limit'] = this.limit;
    return data;
  }
}

class Todos {
  int? id;
  String? todo;
  bool? completed;
  int? userId;

  Todos({this.id, this.todo, this.completed, this.userId});

  Todos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    todo = json['todo'];
    completed = json['completed'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['todo'] = this.todo;
    data['completed'] = this.completed;
    data['userId'] = this.userId;
    return data;
  }
}
