import 'dart:io';

import 'package:flutter/material.dart';

class Sts extends StatefulWidget {
  const Sts({super.key});

  @override
  State<Sts> createState() => _StsState();
}

class _StsState extends State<Sts> {

    triangle(){
    print("Pattern");
    int n=5;
    for(int i=1;i<=5;i++)
    {
      for (int j=1;j<=i;j++)
      {
        stdout.write("*");
      }
      print("");
    }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ElevatedButton(onPressed: ()
        {
          triangle();
          }, child: Text("data")),
    );
  }
}
