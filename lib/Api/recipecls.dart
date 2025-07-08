import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:widproject/Api/incredientscls.dart';

class Recipe extends StatefulWidget {
  const Recipe({super.key});

  @override
  State<Recipe> createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {

  Map<String,dynamic>bodydata={};
  List items=[];
  Future<Recipecls> getdata() async{
    try{
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
      backgroundColor: Color(0xfffc8c1d4),
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
              itemBuilder:(BuildContext,index)
          {
            return Column(
              children: [
                Card(
                  child: ListTile(
                    title: Column(
                      children: [
                        Row(
                          children: [
                            Text("${items[index]["id"].toString()}.",style: TextStyle(fontSize: 18),),
                            Text(items[index]["name"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(items[index]["image"]),fit: BoxFit.fill),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 10,),
                            Column(
                              children: [
                                Icon(Icons.star,color: Colors.yellow,size: 35,),
                                Text(items[index]["rating"].toString())
                              ],
                            ),
                            SizedBox(width: 20,),
                            Column(
                              children: [
                                Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage("prepp.png"),fit: BoxFit.fill)
                                  ),
                                ),
                                Text("${items[index]["prepTimeMinutes"]}mins")
                              ],
                            ),
                            SizedBox(width: 20,),
                            Column(
                              children: [
                                Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage("cook.png"),fit: BoxFit.fill)
                                  ),
                                ),
                                Text("Cook mins:${items[index]["cookTimeMinutes"].toString()}")
                  
                              ],
                            )
                          ],
                        ),
                        
                      ],
                    ),
                    
                    onTap: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Ingredients()));
                    },
                  ),
                ),
              ],
            );
          });
        }
        else
          {
            return Text("No valid API");
          }
      }),
    );
  }
}






class Recipecls {
  List<Recipes>? recipes;
  int? total;
  int? skip;
  int? limit;

  Recipecls({this.recipes, this.total, this.skip, this.limit});

  Recipecls.fromJson(Map<String, dynamic> json) {
    if (json['recipes'] != null) {
      recipes = <Recipes>[];
      json['recipes'].forEach((v) {
        recipes!.add(new Recipes.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recipes != null) {
      data['recipes'] = this.recipes!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['skip'] = this.skip;
    data['limit'] = this.limit;
    return data;
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

