import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Index extends StatefulWidget {
  String a;
  Index({super.key,required this.a});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  Map<String,dynamic>bodydata={};
  List items=[];

  TextEditingController id=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController rollno=TextEditingController();
  TextEditingController year=TextEditingController();
  TextEditingController dept=TextEditingController();
  TextEditingController gender=TextEditingController();

  Future<Map<String, dynamic>>Getbyid(idd) async
  {
    try
        {
          var apiResponse=await http.get(Uri.parse("http://92.205.109.210:8051/api/getbyid/$idd"));
          bodydata=jsonDecode(apiResponse.body);
          if(apiResponse.statusCode==200 || apiResponse.statusCode==201)
            {
              return bodydata;
            }
          else
            {
              throw Exception(apiResponse.body);
            }
        }
        catch(e)
    {
      throw Exception(e);
    }
  }

  @override
  void initState() {
    List item=widget.a.split("\n");

    id=TextEditingController(text: item[0]);
    name=TextEditingController(text: item[1]);
    rollno=TextEditingController(text: item[2]);
    year=TextEditingController(text: item[3]);
    dept=TextEditingController(text: item[4]);
    gender=TextEditingController(text: item[5]);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(future: Getbyid(), builder: (BuildContext,snapshot)
      {
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
            return Column(
              children: [
                TextFormField(controller: id,),
                TextFormField(controller: name,),
                TextFormField(controller: rollno,),
                TextFormField(controller: year,),
                TextFormField(controller: dept,),
                TextFormField(controller: gender,)
              ],
            );
          }
        else
          {
            return Text("No data found");
          }
      }),
    );
  }
}
