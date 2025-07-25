import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Cuisines extends StatefulWidget {

  var twoitem="";
  Cuisines({super.key,required this.twoitem});

  @override
  State<Cuisines> createState() => _CuisinesState();
}

class _CuisinesState extends State<Cuisines> {

  Map<String,dynamic>bodydata={};
  List cusitems=[];
  Future<List>getdata()async
  {
    try
    {
      var apiResponse=await http.get(Uri.parse("https://dummyjson.com/recipes/tag/${widget.twoitem}"));
      bodydata=jsonDecode(apiResponse.body);
      cusitems=bodydata["cuisines"];
      print(bodydata);
      if(apiResponse.statusCode==200)
        {

          return cusitems;
        }
      else {
        throw Exception(apiResponse.body);
      }
    }
    catch(e)
    {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(future: getdata(), builder: (BuildContext,snapshot)
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
            return Column(
              children: [
                Container(
                  height: 600,
                  width: 400,
                  child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      itemCount: cusitems.length,
                      itemBuilder: (BuildContext,index)
                      {
                        return Column(
                          children: [
                            Text(cusitems[index]["id"].toString()),
                          ],
                        );
                      }),
                )
              ],
            );
          }
        else
          {
            return Text("No data found");
          }
      })
    );
  }
}
