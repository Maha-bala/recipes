import 'package:flutter/material.dart';
import 'package:widproject/Api/Weatherapp.dart';
import 'package:widproject/Api/demo_ww.dart';
import 'package:widproject/Api/incredientscls.dart';
import 'package:widproject/Api/ipinfo.dart';
import 'package:widproject/Api/product.dart';
import 'package:widproject/Api/recipecls.dart';
import 'package:widproject/ctrl/btn.dart';
import 'package:widproject/fahrencelsius.dart';

import 'List api/JsonApi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Products()
    );
  }
}

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  
   int counter = 0;
   
   inc()
   {
     setState(() {
       counter++;
     });
   }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
        sce(data: "$counter"),
          Btn(inc: inc),
        ],
      ),
    );
  }
}





