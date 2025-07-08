import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Ipclas extends StatefulWidget {
  const Ipclas({super.key});

  @override
  State<Ipclas> createState() => _IpclasState();
}

class _IpclasState extends State<Ipclas> {

  Map<String,dynamic>bodydata={};
  Future<Ipcls>getdata()async{
    try{
      var apiResponse=await http.get(Uri.parse("https://api.ipify.org/?format=json"));
      if(apiResponse.statusCode==200 || apiResponse.statusCode==201)
      {
        bodydata=jsonDecode(apiResponse.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data fetched successfully")));
        return Ipcls.fromJson(bodydata);
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
      body: FutureBuilder(future: getdata(), builder: (context,snapshot)
      {
        if(snapshot.connectionState==ConnectionState.waiting){
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
              Text(bodydata["ip"])
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



class Ipcls {
  String? ip;

  Ipcls({this.ip});

  Ipcls.fromJson(Map<String, dynamic> json) {
    ip = json['ip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ip'] = this.ip;
    return data;
  }
}
