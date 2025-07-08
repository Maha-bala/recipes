import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();

  Map<String,dynamic> weatherData={};

  bool isLoading = false;

  Future<void> fetchWeather() async {
    final city = _cityController.text.trim();

    if (city.isEmpty) return;

    setState(() {
      isLoading = true;
    });

    final url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$city&appid=94d0003c9da942cd5cb1d42ce5e075d3");

    final response = await http.get(
      url,
      // headers: {
      //   'X-RapidAPI-Key': '94d0003c9da942cd5cb1d42ce5e075d3',
      //   'X-RapidAPI-Host': 'https://openweathermap.org/current',
      // },
    );

    print("API Response: ${response.statusCode}");

    if (response.statusCode == 200) {
      setState(() {
        weatherData = json.decode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        weatherData = {};
        isLoading = false;
      });
    }
  }

  String temp(){
    try{
      String tempinK=weatherData["main"]["temp"].toString();
      print(tempinK);
      double tempinC=double.parse(tempinK)-273.15;
      return tempinC.toStringAsFixed(2);
    }
    catch(e){
      return "null";
    }
  }

  String humidity(){
    try{
      return weatherData["main"]["humidity"].toString();
    }
    catch(e){
      return "null";
    }
  }

  String pressure(){
    try{
      return weatherData["main"]["pressure"].toString();
    }
    catch(e){
      return "null";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      appBar: AppBar(
        title: const Text("Weather App"),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _cityController,
              decoration: const InputDecoration(
                hintText: "Enter city name",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: fetchWeather,
              child: const Text("Get Weather"),
            ),
            const SizedBox(height: 20),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else if (weatherData != null)
              Column(
                children: [
                  Text(
                    "Temperature:${temp()}",
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Humidity:${humidity()}",
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Pressure:${pressure()}",
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Text(
                  //   "${weatherData!['main']['temp']}°C",
                  //   style: const TextStyle(fontSize: 50),
                  // ),
                  // const SizedBox(height: 10),
                  // Text(
                  //   "${weatherData!['weather'][0]['main']}",
                  //   style: const TextStyle(fontSize: 24),
                  // ),
                ],
              )
            else
              const Text("No data available"),
          ],
        ),
      ),
    );
  }
}
