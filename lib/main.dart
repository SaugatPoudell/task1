// import 'dart:ffi';

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'HelpScreen.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:getSkipped()==true?MyHomePage():HelpScreen()
    );
  }
}

class MyHomePage extends StatefulWidget {


  const MyHomePage({super.key});


  

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool apicalled=false;
  bool isSkipped=false;
 String textValue="";
 Map<String ,dynamic>jsonData={};
 
Future<Position>_getLocation() async {
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  //getting the location of the appilcation
  print(position);
  return position;
}

Future<void> getData() async
{
  Position position =await _getLocation();
  print(position);
  if(textValue.isEmpty)
  {
    final response = await http.get(Uri.parse("http://api.weatherapi.com/v1/current.json?key=1bc0383d81444b58b1432929200711&q=${position.latitude},${position.longitude}"));
    jsonData =jsonDecode(response.body);
  }
  else
  {
    final response = await http.get(Uri.parse("http://api.weatherapi.com/v1/current.json?key=1bc0383d81444b58b1432929200711&q=$textValue"));
    jsonData =jsonDecode(response.body);
  }
 if(jsonData.isNotEmpty) //try catch could be better options
 {
  setState(()
  {
    apicalled=true;
  });
print(jsonData['location']['name']);
print(jsonData['current']['temp_c']);
print(jsonData['current']['condition']['text']);
print(jsonData['current']['condition']['icon']);

 } 
else
{
  print("Failed to load");
}

}
//  double _currentLocation=0.0;
//  double latitude=position.latitude;
 @override
  void initState() {
    
    // TODO: implement initState
    super.initState();
     _getLocation(); // getting location of the application 
        getData(); //gettin the data of the entered value by the user
        getSkipped(); //checking if the previous page is skipped or not
         
       
  }


  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
       title: Text("HomePage"),
      ),
      body: Center(
        child: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    
                    onChanged: (value)
                    {
                      // getData();
                      setState((){
                       textValue=value;
                       print(textValue);
                      });
                    },
                    decoration: InputDecoration
                    (
                      
                      hintText: "Enter your Location"
                    ),
                  ),
                )
              ],
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: (){
                    if(textValue.isNotEmpty)
                   { 
                    getData();
                   }
                   else
                   {
                     
                   showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Error"),
                  content: Text('Field is Empty'),
                    );
                    });
                   };
                  }, child: Text
                  (
                    textValue.isEmpty?"Save":"Update",
                  ))
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Column(
              children: [!apicalled&&textValue.isEmpty?
                Text('Loading'):
                Text(jsonData['location']['name']),
                 Text('${jsonData['current']['temp_c']}°C'),
                  Text(jsonData['current']['condition']['text']),
                   Image.network(
                    height: 100.0,
                    width: 100.0,
                    jsonData['current']['condition']['icon'])
              ],
            )
          ],),
        ),
      )
       
      );
  }




}

Future<bool> getSkipped() async {
 
  SharedPreferences prefs = await SharedPreferences.getInstance();

bool skippedValue = prefs.getBool('Skipped')??false;
return skippedValue;
}// setting the value of skip 
