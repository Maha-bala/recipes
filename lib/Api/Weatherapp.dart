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
  Future<void> getdata()async
  {


    try {
      final cityy = ctr.text;
      if(cityy.isEmpty){
        return;
      }

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

    }catch(e){
      throw Exception(e);
    }
  }
  
  
  dynamic cord()
  {
    try{
      var c="Longititude:${bodydata["coord"]["lon"].toString()}";
      return c;
    }
    catch(_){
      return "";
    }
  }

  dynamic hum()
  {
    try{
      var b="Humidity:${bodydata["main"]["humidity"].toString()}";
      return b;
    }
    catch(_){
      return "";
    }
  }

  dynamic weather()
  {
    try{
      var x="Weather:${bodydata["weather"]["description"].toString()}";

      return x;
    }
    catch(_)
    {
      return "";
    }
  }

  dynamic pressure()
  {
    try{
      var y="Pressure:${bodydata["main"]["pressure"].toString()}";
      return y;
    }
    catch(_)
    {
      return "";
    }
  }

  dynamic sun()
  {
    try{
      var z="Sunrise:${bodydata["sys"]["sunrise"].toString()}";
      return z;
    }
    catch(_)
    {
      return "";
    }
  }

 dynamic temp()
 {
   try{
     var a="Temperature${bodydata["main"]["temp"].toString()}";
     return a;


   }
   catch(_)
   {
     return '';
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
          FutureBuilder(future: getdata(), builder: (context,snapshot)
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
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Data Fetched Successfully")));
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Data Fetched Successfully")));
              //var mydata=snapshot.data!;
              return Column(
                children: [
                  Text("Welcome")
                ],
              );
            }
            else
            {
              return Text("No data found");
            }
          }),
          Container(
            height: 400,
            width: 400,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("sunny.jpeg"),fit: BoxFit.fill)
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: ctr,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "City Name",
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder()
                    ),
                  ),
                ),
                ElevatedButton(onPressed: ()
                {
                  setState(() {
                    getdata();
                  });
                }, child: Text("Get Weather")),

                Text("${temp()}",style: TextStyle(fontSize: 45),),
                Text("${cord()}"),
                Text("${hum()}"),
                Text("${pressure()}"),
                Text("${sun()}"),
              ],
            ),
          ),
        ],
      )
    );
  }
}











