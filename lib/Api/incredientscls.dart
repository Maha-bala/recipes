import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Ingredients extends StatefulWidget {
  Map<String,dynamic>oneItem={};
      Ingredients({super.key,required this.oneItem});

  @override
  State<Ingredients> createState() => _IngredientsState();
}

class _IngredientsState extends State<Ingredients> {

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
        /* body: FutureBuilder(future: getdata(), builder: (context,snapshot)
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
                    Text(items[index]["ingredients"].toString()),

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
      ),*/
      body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Row(
                children: [
                  Text("${widget.oneItem["id"].toString()}.",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Text(widget.oneItem["name"],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 300,
                  width: 400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      image: DecorationImage(image: NetworkImage(widget.oneItem["image"]),fit: BoxFit.fill),
                      shape: BoxShape.rectangle
                  ),
                  child: Column(
                    children: [
                      Spacer(),
                      Row(
                        children: [
                          Spacer(),
                          Text("Cuisine :",style: GoogleFonts.dancingScript(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold)),
                          Text(widget.oneItem["cuisine"],style: GoogleFonts.dancingScript(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(text: TextSpan(text: "INGREDIENTS",style: TextStyle(decoration: TextDecoration.underline,color: Colors.purple,fontSize: 19))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: 400,
                  child: ListView.builder(
                    itemCount: widget.oneItem["ingredients"].length,
                      itemBuilder: (BuildContext,int index)
                  {
                    return Column(
                      children: [
                        SizedBox(width: 20,),
                        Row(
                          children: [
                            Text("*${widget.oneItem["ingredients"][index]}",style: TextStyle(fontSize: 16),),
                          ],
                        ),
                      ],
                    );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(text: TextSpan(text: "Step by step process",style: TextStyle(decoration: TextDecoration.underline,color: Colors.red,fontSize: 19)),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200,
                  width: 400,
                  child: ListView.builder(
                    itemCount: widget.oneItem["instructions"].length,
                      itemBuilder: (BuildContext,int index)
                  {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("*${widget.oneItem["instructions"][index]}",style: TextStyle(fontSize: 16),),
                      ],
                    );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    Container(
                      height: 85,
                      width: 95,
                      decoration: BoxDecoration(
                          color: Color(0xfff81f0c5),
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 15,),
                          Text("SERVINGS",style: TextStyle(fontSize: 18),),
                          Text(widget.oneItem["servings"].toString(),style: TextStyle(fontSize: 18),),
                        ],
                      ),
                    ),
                    Container(
                      height: 85,
                      width: 95,
                      decoration: BoxDecoration(
                          color: Color(0xffff0a1a1),
                          borderRadius: BorderRadius.circular(15),shape: BoxShape.rectangle
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 15,),
                          Text("CALORIES",style: TextStyle(fontSize: 18),),
                          Text(widget.oneItem["caloriesPerServing"].toString(),style: TextStyle(fontSize: 18),),
                        ],
                      ),
                    ),

                    Container(
                      height: 85,
                      width: 105,
                      decoration: BoxDecoration(
                          color: Color(0xfffab64ed),
                          borderRadius: BorderRadius.circular(15),shape: BoxShape.rectangle
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 15,),
                          Text("DIFFICULTY",style: TextStyle(fontSize: 18),),
                          Text(widget.oneItem["difficulty"],style: TextStyle(fontSize: 18),),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}










