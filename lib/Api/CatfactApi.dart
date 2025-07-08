import 'dart:convert';

import'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Catfact extends StatefulWidget {
  const Catfact({super.key});

  @override
  State<Catfact> createState() => _CatfactState();
}

class _CatfactState extends State<Catfact> {
  Map<String,dynamic> bodyData={};
  Future<Catclass> getData() async{
    try {
      var apiResponse = await http.get(Uri.parse("https://catfact.ninja/fact"));

      if (apiResponse.statusCode == 200 || apiResponse.statusCode == 201) {
          bodyData = jsonDecode(apiResponse.body);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Data fetched successfully")));
        return Catclass.fromJson(bodyData);
      }
      else {
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
        title: Text("Catfact Api"),
      ),
      body: FutureBuilder(future:getData() , builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        else if(snapshot.hasError){
          return Text("Error :${snapshot.error}");
        }
        else if(snapshot.hasData){
          var myData=snapshot.data!;
          return Column(
            children: [
              Text(bodyData["fact"]),
              Text(bodyData["length"].toString())

            ],
          );
        }
        else{
          return Text("No data found");
        }
      }),
    );
  }
}


class Catclass {
  String? fact;
  int? length;

  Catclass({this.fact, this.length});

  Catclass.fromJson(Map<String, dynamic> json) {
    fact = json['fact'];
    length = json['length'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fact'] = this.fact;
    data['length'] = this.length;
    return data;
  }


}
