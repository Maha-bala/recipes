import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class WeatherApi extends StatefulWidget {
  const WeatherApi({super.key});

  @override
  State<WeatherApi> createState() => _WeatherApiState();
}

class _WeatherApiState extends State<WeatherApi> {

  @override
  void initState() {
    getdata();
    super.initState();
  }
  
  TextEditingController ctr=TextEditingController();


  
  Map<String,dynamic>bodydata={};
  Future<void>getdata()async
  {

    try {
      final cityy = ctr.text;
      if (cityy.isNotEmpty) {
        var apiResponse = await http.get(Uri.parse(
            "https://api.openweathermap.org/data/2.5/weather?q=$cityy&appid=f6ed274898d723e5d4a22c1261ecc027&units=metric"));

        if (apiResponse.statusCode == 200) {
          bodydata = jsonDecode(apiResponse.body);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Data Fetched Successfully")));
          print(bodydata);
          //  return Weatherapi.fromJson(bodydata);
        }
        else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Failed to fetch data")));
        }
      }
    }catch(e){
      throw Exception(e);
    }
  }
  
  
  dynamic cord()
  {
    try{
      return bodydata["coord"]["lon"].toString();
    }
    catch(e){
      return "null";
    }
  }

  dynamic hum()
  {
    try{
      return bodydata["main"]["humidity"].toString();
    }
    catch(e){
      return "null";
    }
  }

  dynamic weather()
  {
    try{
      return bodydata["weather"]["description"].toString();
    }
    catch(e)
    {
      return "null";
    }
  }

  dynamic pressure()
  {
    try{
      return bodydata["main"]["pressure"].toString();
    }
    catch(e)
    {
      return "null";
    }
  }

  dynamic sun()
  {
    try{
      return bodydata["sys"]["sunrise"].toString();
    }
    catch(e)
    {
      return "null";
    }
  }

 dynamic temp()
 {
   try{
     String k=bodydata["main"]["temp"].toString();
     double c=double.parse(k)-273.15;
     return c.toStringAsFixed(2);
   }
   catch(e)
   {
     return 'null';
   }
 }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("",style: TextStyle(color: Colors.white,fontSize: 15),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.dashboard,color: Colors.white,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.settings,color: Colors.white,),
          )
        ],
      ),

      body: Column(
        children: [
          TextFormField(controller: ctr,),
          ElevatedButton(onPressed: ()
          {
            getdata();
          }, child: Text("Press")),
          bodydata.isNotEmpty?
          Column(
            children: [
              Text(temp()),
              Text(pressure()),
            ],
          ):Text("Please enter city")
        ],
      )




    );
  }
}











