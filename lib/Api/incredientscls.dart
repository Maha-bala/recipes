import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:widproject/Api/recipecls.dart';

class Ingredients extends StatefulWidget {
  const Ingredients({super.key});

  @override
  State<Ingredients> createState() => _IngredientsState();
}

class _IngredientsState extends State<Ingredients> {

  Map<String,dynamic>bodydata={};
  List items=[];
  Future<Recipecls>getdata()async
  {
    try
        {
          var apiResponse=await http.get(Uri.parse("https://dummyjson.com/recipes"));
          bodydata=jsonDecode(apiResponse.body);
          print(bodydata);
          if(apiResponse.statusCode==200)
            {
              items=bodydata["recipes"];
              return Recipecls.fromJson(bodydata);
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
      appBar: AppBar(
        title: Text("Smart Chef"),
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
            return ListView.builder(
              itemCount: items.length,
                itemBuilder: (BuildContext,index)
            {
              return ListTile(

                title: Column(
                  children: [
                    Row(
                      children: [
                        Text("${items[index]["id"].toString()}.",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        Text(items[index]["name"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Image(image: NetworkImage(items[index]["image"])),
                    Row(
                      children: [
                        RichText(text: TextSpan(text: "INGREDIENTS",style: TextStyle(decoration: TextDecoration.underline,color: Colors.pink,fontSize: 18)))
                      ],
                    ),
                    Text(items[index]["ingredients"][0]),
                    Text(items[index]["ingredients"][1]),
                    Text(items[index]["ingredients"][2]),
                    Text(items[index]["ingredients"][3]),
                    Text(items[index]["ingredients"][4]),

                    Row(
                      children: [
                        RichText(text: TextSpan(text: "INSTRUCTIONS",style: TextStyle(decoration: TextDecoration.underline,color: Colors.deepPurpleAccent,fontSize: 18)))
                      ],
                    ),
                    Text(items[index]["instructions"][0]),
                    Text(items[index]["instructions"][1]),
                    Text(items[index]["instructions"][2]),
                    Text(items[index]["instructions"][3]),
                    Row(
                      children: [
                        RichText(text: TextSpan(text: "Servings : ${items[index]["servings"].toString()}",style: TextStyle(color: Colors.purpleAccent,fontSize: 18))),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(text: TextSpan(text: "MealType : ${items[index]["mealType"]}",style: TextStyle(color: Colors.brown,fontSize: 18))),
                        )

                      ],
                    ),
                    Text("Cuisine:${items[index]["cuisine"]}",style: TextStyle(fontSize: 18,color: Colors.black),)
                  ],
                ),
              );
            });
          }
        else
          {
            return Text("No data found");
          }
      }
      ),
    );
  }
}










class Recipes {
  int? id;
  String? name;
  List<String>? ingredients;
  List<String>? instructions;
  int? prepTimeMinutes;
  int? cookTimeMinutes;
  int? servings;
  String? difficulty;
  String? cuisine;
  int? caloriesPerServing;
  List<String>? tags;
  int? userId;
  String? image;
  double? rating;
  int? reviewCount;
  List<String>? mealType;

  Recipes(
      {this.id,
        this.name,
        this.ingredients,
        this.instructions,
        this.prepTimeMinutes,
        this.cookTimeMinutes,
        this.servings,
        this.difficulty,
        this.cuisine,
        this.caloriesPerServing,
        this.tags,
        this.userId,
        this.image,
        this.rating,
        this.reviewCount,
        this.mealType});

  Recipes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    ingredients = json['ingredients'].cast<String>();
    instructions = json['instructions'].cast<String>();
    prepTimeMinutes = json['prepTimeMinutes'];
    cookTimeMinutes = json['cookTimeMinutes'];
    servings = json['servings'];
    difficulty = json['difficulty'];
    cuisine = json['cuisine'];
    caloriesPerServing = json['caloriesPerServing'];
    tags = json['tags'].cast<String>();
    userId = json['userId'];
    image = json['image'];
    rating = json['rating'];
    reviewCount = json['reviewCount'];
    mealType = json['mealType'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['ingredients'] = this.ingredients;
    data['instructions'] = this.instructions;
    data['prepTimeMinutes'] = this.prepTimeMinutes;
    data['cookTimeMinutes'] = this.cookTimeMinutes;
    data['servings'] = this.servings;
    data['difficulty'] = this.difficulty;
    data['cuisine'] = this.cuisine;
    data['caloriesPerServing'] = this.caloriesPerServing;
    data['tags'] = this.tags;
    data['userId'] = this.userId;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['reviewCount'] = this.reviewCount;
    data['mealType'] = this.mealType;
    return data;
  }
}
