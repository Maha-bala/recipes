import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  
  Map<String,dynamic>bodydata={};
  Future<Ipinfo>getdata()async{
    try{
      var apiResponse=await http.get(Uri.parse("https://ipinfo.io/161.185.160.93/geo"));
      
      if(apiResponse.statusCode==200 || apiResponse.statusCode==201)
        {
          bodydata=jsonDecode(apiResponse.body);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data fetched successfully")));
          return Ipinfo.fromJson(bodydata);
        }
      else 
        {
          throw Exception(apiResponse.body);
        }
    }catch(e){
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
                Text(bodydata["ip"].toString()),
                Text(bodydata["city"].toString()),
                Text(bodydata["region"].toString()),
                Text(bodydata["country"].toString()),
                Text(bodydata["log"].toString()),
                Text(bodydata["org"].toString()),
                Text(bodydata["postal"].toString()),
                Text(bodydata["timezone"].toString()),
                Text(bodydata["readme"].toString())
                
              ],
            );
          }
        else
          {
            return Text("No data fetched");
          }
      }),
    );
  }
}



class Ipinfo {
  String? ip;
  String? city;
  String? region;
  String? country;
  String? loc;
  String? org;
  String? postal;
  String? timezone;
  String? readme;

  Ipinfo(
      {
        this.ip,
        this.city,
        this.region,
        this.country,
        this.loc,
        this.org,
        this.postal,
        this.timezone,
        this.readme
      }
      );

  Ipinfo.fromJson(Map<String, dynamic> json)
  {
    ip = json['ip'];
    city = json['city'];
    region = json['region'];
    country = json['country'];
    loc = json['loc'];
    org = json['org'];
    postal = json['postal'];
    timezone = json['timezone'];
    readme = json['readme'];
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ip'] = this.ip;
    data['city'] = this.city;
    data['region'] = this.region;
    data['country'] = this.country;
    data['loc'] = this.loc;
    data['org'] = this.org;
    data['postal'] = this.postal;
    data['timezone'] = this.timezone;
    data['readme'] = this.readme;
    return data;
  }
}
