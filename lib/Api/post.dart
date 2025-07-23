import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:widproject/Api/index.dart';


class StudentRecord extends StatefulWidget {
  const StudentRecord({super.key});

  @override
  State<StudentRecord> createState() => _StudentRecordState();
}

class _StudentRecordState extends State<StudentRecord> {
  Map<String,dynamic> bodyData={};

  List items=[];
  late Future<Map<String,dynamic>> f1;

  TextEditingController id=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController rollno=TextEditingController();
  TextEditingController year=TextEditingController();
  TextEditingController dept=TextEditingController();
  TextEditingController gender=TextEditingController();




  TextEditingController id1=TextEditingController();
  TextEditingController name1=TextEditingController();
  TextEditingController rollno1=TextEditingController();
  TextEditingController year1=TextEditingController();
  TextEditingController dept1=TextEditingController();
  TextEditingController gender1=TextEditingController();




  void initState(){
    super.initState();
    f1=getdata();
  }

  Future<Map<String,dynamic>> getdata() async
  {
    try
    {
      var apiResponse=await http.get(Uri.parse("http://92.205.109.210:8051/api/getall"));
      bodyData=jsonDecode(apiResponse.body);
      print(bodyData);
      print(apiResponse.statusCode);
      if(apiResponse.statusCode==201)
      {
        items=bodyData["data"];
        return bodyData;
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

  Future<void> addStudent() async{
    try {
      var apiResponse = await http.post(
          Uri.parse("http://92.205.109.210:8051/api/create"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            // "_id": "686caad3dd65373e8c7047d6",
            "studentId": id.text.toString(),
            "name": name.text,
            "rollno": rollno.text.toString(),
            "year": year.text.toString(),
            "department": dept.text,
            "gender": gender.text
          })
      );
      bodyData=jsonDecode(apiResponse.body);
      name.clear();
      rollno.clear();
      year.clear();
      dept.clear();
      gender.clear();

      if (apiResponse.statusCode==200||apiResponse.statusCode==201){
        print(bodyData["message"]);
        setState(() {
          f1=getdata();
        });
      }
      else{
        print("Failed to add data");
        throw Exception("Failed to add");
      }
    }
    catch(e){
      throw Exception(e);
    }
  }
  
  Future<void> UpdateStudent(int iid) async
  {
    try
        {
          var apiResponse=await http.post(Uri.parse("http://92.205.109.210:8051/api/update/$iid"),
            headers: {"Content-Type" : "application/json"},
            body: jsonEncode({
              "studentId": id1.text.toString(),
              "name":name1.text,
              "rollno":rollno1.text.toString(),
              "year":year1.text.toString(),
              "department":dept1.text,
              "gender":gender1.text
            }
            )
          );
          bodyData=jsonDecode(apiResponse.body);

          if(apiResponse.statusCode==200 || apiResponse.statusCode==201)
            {
             setState(() {
               f1=getdata();
             });
             name.clear();
             year.clear();
             dept.clear();
             rollno.clear();
             gender.clear();
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

  Future<void> deleteStudent(iid2) async
  {
    try
        {
          var apiResponse=await http.post(Uri.parse("http://92.205.109.210:8051/api/delete/$iid2"));
          bodyData=jsonDecode(apiResponse.body);
          if(apiResponse.statusCode==200||apiResponse.statusCode==201)
            {
              print(bodyData["message"]);
              setState(() {
                f1=getdata();
              });
            }
          else
            {
              throw Exception(apiResponse.body);
            }
        }catch(e)
    {
      throw Exception(e);
    }
  }


  void Popup(item)
  {
    showDialog(context: context, builder: (BuildContext)
    {
      id1=TextEditingController(text: item["studentId"].toString());
      name1=TextEditingController(text: item["name"]);
      rollno1=TextEditingController(text: item["rollno"].toString());
      year1=TextEditingController(text: item["year"].toString());
      dept1=TextEditingController(text: item["department"]);
      gender1=TextEditingController(text: item["gender"]);

      return AlertDialog(

        title: Column(
          children: [
            TextFormField(
              controller: id1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: name1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: rollno1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: year1,
              decoration: InputDecoration(
                  border: OutlineInputBorder()
              ),
            ),
            TextFormField(controller: dept1,
              decoration: InputDecoration(
                  border: OutlineInputBorder()
              ),
            ),
            TextFormField(controller: gender1,
              decoration: InputDecoration(
                  border: OutlineInputBorder()
              ),
            )

          ],
        ),
        actions: [
          ElevatedButton(onPressed: ()
          {
            setState(() {
              UpdateStudent(item["studentId"]);
              print(item["studentId"]);
              //UpdateStudent(item["studentId"]);
              //Navigator.pop(context);
            });
          }, child: Text("Update"))
        ],
      );
    });
  }

  route(String data)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Index(a: data))).then((edit)
    {
      setState(() {
        items[items.indexWhere((element)=>element==data)]=edit;
      });
    });
  }

  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: id,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Id",
                  prefixIcon: Icon(Icons.numbers)
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: name,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Name",
                  prefixIcon: Icon(Icons.person)
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: rollno,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Rollno",
                  prefixIcon: Icon(Icons.format_list_numbered)
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: year,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.calendar_month),
                  border: OutlineInputBorder(),
                  labelText: "Year"
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: dept,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.table_rows_outlined),
                  hintText: "Department",
                  border: OutlineInputBorder()
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: gender,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: "Gender",
                  border: OutlineInputBorder()
              ),
            ),
          ),
          ElevatedButton(onPressed: (){
            addStudent();
          }, child: Text("Add")),


        Expanded(
          child: FutureBuilder(future:f1, builder: (BuildContext context,snapshot)
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
                return Container(
                  height: 400,
                  width: 300,
                  color: Colors.yellow,
                  child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext,index)
                      {
                        var item=items[index];
                        return GestureDetector(
                          onTap: ()
                          {
                            route(items[index]);
                          },
                          child: Container(
                            height: 130,
                            width: 200,

                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(item["studentId"].toString()??"null"),
                                        Text(item["name"]??"null"),
                                        Text(item["rollno"].toString()??"null"),
                                        Text(item["year"].toString()??"null"),
                                        Text(item["department"]??"null"),
                                        Text(item["gender"]??"null")
                                      ],
                                    ),
                                    IconButton(onPressed: ()
                                    {
                                      Popup(item);
                                      },
                                        icon: Icon(Icons.edit)),
                                    IconButton(onPressed: ()
                                    {
                                      setState(() {

                                        deleteStudent(item["studentId"]);
                                      });
                                    }, icon: Icon(Icons.delete))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                );
              }
              else
                {
                  return Text("No data found");
                }
            }
            ),
        ),
        ],
      )
    );
  }
}
