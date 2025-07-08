import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Jokeapi extends StatefulWidget {
  const Jokeapi({super.key});

  @override
  State<Jokeapi> createState() => _JokeapiState();
}

class _JokeapiState extends State<Jokeapi> {

  Map<String,dynamic>bodydata={};
  Future<Jokecls>getdata()async{
    try{
      var apiresponse=await http.get(Uri.parse("https://official-joke-api.appspot.com/random_joke"));

      if(apiresponse.statusCode==200 || apiresponse.statusCode==201)
      {
        bodydata=jsonDecode(apiresponse.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data fetched successfully")));
        return Jokecls.fromJson(bodydata);
      }
      else
        {
          throw Exception(apiresponse.body);
        }
    }catch(e)
    {
      throw Exception(e);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(future: getdata(), builder: (context,snapshot)
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
            var mydata=snapshot.data!;
            return Column(
              children: [
                Text(bodydata["type"].toString()),
                Text(bodydata["setup"].toString()),
                Text(bodydata["punchline"].toString()),
                Text(bodydata["id"].toString())
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


class Jokecls {
  String? type;
  String? setup;
  String? punchline;
  int? id;

  Jokecls({this.type, this.setup, this.punchline, this.id});

  Jokecls.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    setup = json['setup'];
    punchline = json['punchline'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['setup'] = this.setup;
    data['punchline'] = this.punchline;
    data['id'] = this.id;
    return data;
  }
}