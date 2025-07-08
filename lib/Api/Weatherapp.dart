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
  Future<Weatherapi>getdata()async
  {

    try{
      final cityy=ctr.text;
      var apiResponse=await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$cityy&appid=f6ed274898d723e5d4a22c1261ecc027&units=metric"));

      if(apiResponse.statusCode==200)
        {
          bodydata=jsonDecode(apiResponse.body);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data Fetched Successfully")));
          return Weatherapi.fromJson(bodydata);
        }
      else
        {
          throw Exception(apiResponse.body);
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
        backgroundColor: Color(0xfff162e90),
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
      backgroundColor: Color(0xfff162e90),
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
                var mydata=snapshot.data!;
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
                Text("Longitude:${cord()}"),
                Text("Humidity:${hum()}"),
                Text("Pressure:${pressure()}"),
                Text("Sunrise:${sun()}"),

              ],
            ),
          ),
        ],
      ),
    );
  }
}











class Weatherapi {
  Coord? coord;
  List<Weather>? weather;
  String? base;
  Main? main;
  int? visibility;
  Wind? wind;
  Clouds? clouds;
  int? dt;
  Sys? sys;
  int? timezone;
  int? id;
  String? name;
  int? cod;

  Weatherapi(
      {this.coord,
        this.weather,
        this.base,
        this.main,
        this.visibility,
        this.wind,
        this.clouds,
        this.dt,
        this.sys,
        this.timezone,
        this.id,
        this.name,
        this.cod});

  Weatherapi.fromJson(Map<String, dynamic> json) {
    coord = json['coord'] != null ? new Coord.fromJson(json['coord']) : null;
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(new Weather.fromJson(v));
      });
    }
    base = json['base'];
    main = json['main'] != null ? new Main.fromJson(json['main']) : null;
    visibility = json['visibility'];
    wind = json['wind'] != null ? new Wind.fromJson(json['wind']) : null;
    clouds =
    json['clouds'] != null ? new Clouds.fromJson(json['clouds']) : null;
    dt = json['dt'];
    sys = json['sys'] != null ? new Sys.fromJson(json['sys']) : null;
    timezone = json['timezone'];
    id = json['id'];
    name = json['name'];
    cod = json['cod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coord != null) {
      data['coord'] = this.coord!.toJson();
    }
    if (this.weather != null) {
      data['weather'] = this.weather!.map((v) => v.toJson()).toList();
    }
    data['base'] = this.base;
    if (this.main != null) {
      data['main'] = this.main!.toJson();
    }
    data['visibility'] = this.visibility;
    if (this.wind != null) {
      data['wind'] = this.wind!.toJson();
    }
    if (this.clouds != null) {
      data['clouds'] = this.clouds!.toJson();
    }
    data['dt'] = this.dt;
    if (this.sys != null) {
      data['sys'] = this.sys!.toJson();
    }
    data['timezone'] = this.timezone;
    data['id'] = this.id;
    data['name'] = this.name;
    data['cod'] = this.cod;
    return data;
  }
}

class Coord {
  double? lon;
  int? lat;

  Coord({this.lon, this.lat});

  Coord.fromJson(Map<String, dynamic> json) {
    lon = json['lon'];
    lat = json['lat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lon'] = this.lon;
    data['lat'] = this.lat;
    return data;
  }
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['main'] = this.main;
    data['description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}

class Main {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;
  int? seaLevel;
  int? grndLevel;

  Main(
      {this.temp,
        this.feelsLike,
        this.tempMin,
        this.tempMax,
        this.pressure,
        this.humidity,
        this.seaLevel,
        this.grndLevel});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    feelsLike = json['feels_like'];
    tempMin = json['temp_min'];
    tempMax = json['temp_max'];
    pressure = json['pressure'];
    humidity = json['humidity'];
    seaLevel = json['sea_level'];
    grndLevel = json['grnd_level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp'] = this.temp;
    data['feels_like'] = this.feelsLike;
    data['temp_min'] = this.tempMin;
    data['temp_max'] = this.tempMax;
    data['pressure'] = this.pressure;
    data['humidity'] = this.humidity;
    data['sea_level'] = this.seaLevel;
    data['grnd_level'] = this.grndLevel;
    return data;
  }
}

class Wind {
  double? speed;
  int? deg;
  double? gust;

  Wind({this.speed, this.deg, this.gust});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
    deg = json['deg'];
    gust = json['gust'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['speed'] = this.speed;
    data['deg'] = this.deg;
    data['gust'] = this.gust;
    return data;
  }
}

class Clouds {
  int? all;

  Clouds({this.all});

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['all'] = this.all;
    return data;
  }
}

class Sys {
  String? country;
  int? sunrise;
  int? sunset;

  Sys({this.country, this.sunrise, this.sunset});

  Sys.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    return data;
  }
}