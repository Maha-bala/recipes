import 'package:flutter/material.dart';

class Fahre extends StatefulWidget {
  const Fahre({super.key});

  @override
  State<Fahre> createState() => _FahreState();
}

class _FahreState extends State<Fahre> {

  TextEditingController ctr=TextEditingController();

  double fahree=0;
  double cel=0.0;
  int k=0;

  func()
  {
    var fahr=int.parse(ctr.text);
    var kelvin=int.parse(ctr.text);
    setState(() {
      cel=(fahr-32)*5/9;
      fahree=(kelvin-273.15)*9/5+32;
    });


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(controller: ctr,),
          ElevatedButton(onPressed: ()
          {
            func();
          }, child: Text("Fahrenheit")),
          Text("Fahrenheit to celsius:$cel"),
          Text("Kelvin to fahrenheit:$fahree")
        ],
      ),
    );
  }
}
