import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Gendercls extends StatefulWidget {
  const Gendercls({super.key});

  @override
  State<Gendercls> createState() => _GenderclsState();
}

class _GenderclsState extends State<Gendercls> {
  
  Map<String,dynamic>bodydata={};
  Future<Genderizecls>getdata()async{
    try{
      var apiResponse=await http.get(Uri.parse("https://api.genderize.io/?name=luc"));
      if(apiResponse.statusCode==200||apiResponse.statusCode==201){
        bodydata=jsonDecode(apiResponse.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data fetched successfully")));
        return Genderizecls.fromJson(bodydata);
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(future: getdata(), builder:(context,snapshot)
      {
        if(snapshot.connectionState==ConnectionState)
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
                Text(bodydata["count"].toString()),
                Text(bodydata["name"]),
                Text(bodydata["gender"]),
                Text(bodydata["probability"].toString())
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


class Genderizecls {
  int? count;
  String? name;
  String? gender;
  double? probability;

  Genderizecls({this.count, this.name, this.gender, this.probability});

  Genderizecls.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    name = json['name'];
    gender = json['gender'];
    probability = json['probability'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['probability'] = this.probability;
    return data;
  }
}
