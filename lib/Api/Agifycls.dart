import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Aficls extends StatefulWidget {
  const Aficls({super.key});

  @override
  State<Aficls> createState() => _AficlsState();
}

class _AficlsState extends State<Aficls> {

  Map<String,dynamic> bodydata={};
  Future<Agifycls>getdata()async{
    try{
      var apiResponse = await http.get(Uri.parse("https://api.agify.io/?name=meelad"));

      if(apiResponse.statusCode ==200||apiResponse.statusCode==201){
        bodydata=jsonDecode(apiResponse.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data fetched successfully")));
        return Agifycls.fromJson(bodydata);
      }
      else
      {
        throw Exception(apiResponse.body);
      }
    }
    catch(e){
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agifycls"),
      ),
      body: FutureBuilder(future: getdata(), builder: (context,snapshot)
    {
      if(snapshot.connectionState==ConnectionState){
        return CircularProgressIndicator();
      }
      else if(snapshot.hasError)
      {
        return Text("Error:${snapshot.error}");
      }
      else if(snapshot.hasData)
      {
        var mydata=snapshot.data!;
        return Column(
          children: [
            Text(bodydata["count"].toString()),
            Text(bodydata["name"]),
            Text(bodydata["age"].toString())
          ],
        );
      }
      else
        {
          return Text("no data found");
        }
    }
    ),

    );
  }
}


class Agifycls {
  int? count;
  String? name;
  int? age;

  Agifycls({this.count, this.name, this.age});

  Agifycls.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    name = json['name'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['name'] = this.name;
    data['age'] = this.age;
    return data;
  }
}