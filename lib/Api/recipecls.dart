import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:widproject/Api/cuisine.dart';
import 'package:widproject/Api/incredientscls.dart';


class Recipe extends StatefulWidget {
  const Recipe({super.key});

  @override
  State<Recipe> createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {

  Map<String,dynamic>bodydata={};
  List items=[];

  List cuisineImages=[
    "https://cdn.dummyjson.com/recipe-images/2.webp",
    "https://cdn.dummyjson.com/recipe-images/3.webp",
    "https://cdn.dummyjson.com/recipe-images/4.webp",
    "https://cdn.dummyjson.com/recipe-images/5.webp",
    "https://cdn.dummyjson.com/recipe-images/6.webp",
    "https://cdn.dummyjson.com/recipe-images/6.webp",
    "https://cdn.dummyjson.com/recipe-images/6.webp",
    "https://cdn.dummyjson.com/recipe-images/6.webp",
    "https://cdn.dummyjson.com/recipe-images/6.webp",
    "https://cdn.dummyjson.com/recipe-images/6.webp",
    "https://cdn.dummyjson.com/recipe-images/6.webp",
    "https://cdn.dummyjson.com/recipe-images/6.webp",
    "https://cdn.dummyjson.com/recipe-images/6.webp",
    ];



  TextEditingController ctr=TextEditingController();

  List myCuisines=[];


  Future<Map> getdata() async{
    try{
      var apiResponse=await http.get(Uri.parse("https://dummyjson.com/recipes"));
      bodydata=jsonDecode(apiResponse.body);
      print(bodydata);
      if(apiResponse.statusCode==200)
      {
        items=bodydata["recipes"];
        print("Food items: $items");
        List cusi=items.map((element)=>element["tags"]).toList();
        print("Cuisines List: $cusi");
        for(var cui in cusi){
          if(!myCuisines.contains(cui)){
            myCuisines.add(cui);
          }
        }
        print(myCuisines);
        for(var cuisi in items)
        {
          print(cuisi["image"]);
        }
        return bodydata;
      }
      else
      {
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
      backgroundColor: Color(0xfffc8c1d4),
      appBar: AppBar(
        title: TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(Icons.search),
            hintText: "search...",
            labelText: "Recipes",
            border: OutlineInputBorder(),
          ),
        ),
        backgroundColor: Color(0xfffc8c1d4),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.menu),
          )
        ],
      ),
      body: FutureBuilder(future: getdata(), builder: (context,snapshot)
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
              Text("Categories",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              Container(
                height: 150,
                width: 400,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,

                  itemCount: cuisineImages.length,
                    itemBuilder: (BuildContext,index)
                {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Cuisines(twoitem:myCuisines[index] )));
                      },
                      child: Container(
                        height: 65,
                        width: 105,
                        decoration: BoxDecoration(
                             image: DecorationImage(image: NetworkImage(cuisineImages[index]),fit: BoxFit.fill),
                          shape: BoxShape.rectangle
                        ),
                        child: Text(myCuisines[index]),
                      ),
                    ),
                  );
                }),
              ),

            ],
          );
        }
        else
          {
            return Text("No valid API");
          }
      }),
    );
  }
}







