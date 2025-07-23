import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  TextEditingController _city = TextEditingController();
  Map<String, dynamic> bodyData = {};
  String city = "";

  Future<void> getData() async {
    try {
      city = _city.text.trim().toLowerCase();

      if (city.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter a city name")),
        );
        return;
      }

      var res = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=5c84ee998e5c0b1e3ae4ff0d34ded67d",
        ),
      );

      print(res.statusCode);
      print(res.body);

      if (res.statusCode == 200) {
        setState(() {
          bodyData = jsonDecode(res.body);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("City not found or API error")),
        );
      }
    } catch (e) {
      print(" Exception: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went wrong")),
      );
    }
  }

  String getLat() {
    try {
      return bodyData["coord"]["lat"].toString();
    } catch (_) {
      return "null";
    }
  }

  String getLon() {
    try {
      return bodyData["coord"]["lon"].toString();
    } catch (_) {
      return "null";
    }
  }

  String temp() {
    try {
      return "${bodyData["main"]["temp"]}°C";
    } catch (_) {
      return "null";
    }
  }

  String weatherDesc() {
    try {
      return bodyData["weather"][0]["description"];
    } catch (_) {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Weather App")),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child:Column(
              children: [
                TextFormField(
                  controller: _city,
                  decoration: const InputDecoration(
                    labelText: "Enter city name",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: getData,
                  child: const Text("Search"),
                ),
                const SizedBox(height: 20),


                bodyData.isNotEmpty
                    ? Column(
// crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("City: ${city.toUpperCase()}",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text("Temperature: ${temp()}"),
                    Text("Latitude: ${getLat()}"),
                    Text("Longitude: ${getLon()}"),
                    Text("Weather: ${weatherDesc()}"),
                  ],
                )
                    : Text("Please enter city name")

                ,
              ],
            )
        )
    );
  }
}