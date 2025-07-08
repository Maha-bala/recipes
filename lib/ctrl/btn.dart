import 'package:flutter/material.dart';

class Btn extends StatelessWidget {
  void Function() inc;
   Btn({super.key,required this.inc});

  @override
  Widget build(BuildContext context){
    return   Expanded(
      flex: 1,
      child: Container(
        width: double.infinity,
        color: Colors.limeAccent,
        child: OutlinedButton(onPressed: inc, child: Text("add")),

      ),
    );
  }
}


class sce extends StatelessWidget {
  String data;
   sce({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      flex: 9,
      child: Container(

        width: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$data",style: TextStyle(fontSize: 45),),
          ],
        ),

      ),
    );
  }
}
