import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class Dogapi extends StatefulWidget {
  const Dogapi({super.key});

  @override
  State<Dogapi> createState() => _DogapiState();
}

class _DogapiState extends State<Dogapi> {

  Map<String,dynamic>bodydata={};
  Future<Dogecls>getdata()async
  {
    try{
    var apiResponse=await http.get(Uri.parse("https://dog.ceo/api/breeds/image/random"));
    if(apiResponse.statusCode==200 || apiResponse.statusCode==201)
    {
      bodydata=jsonDecode(apiResponse.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data fetched successfully")));
      return Dogecls.fromJson(bodydata);
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
      body: FutureBuilder(future: getdata(), builder: (context,snapshot){
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
              Text(bodydata["status"]),
              Image.network(bodydata["message"])
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


class Dogecls {
  String? message;
  String? status;

  Dogecls({this.message, this.status});

  Dogecls.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}
