import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
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
        home:MyHomePage()
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
    //if text value is empty the defualt address of application is displayed
  }
  else
  {
    final response = await http.get(Uri.parse("http://api.weatherapi.com/v1/current.json?key=1bc0383d81444b58b1432929200711&q=$textValue"));
    jsonData =jsonDecode(response.body);
    //text is filled then place entered is searched for the weather
  }
 if(jsonData.isNotEmpty) //try catch could be better options
 {
  setState(()
  {
    apicalled=true;
    //to check if the api has been called or not
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
 @override
  void initState() {
    
    // TODO: implement initState
    super.initState();
     _getLocation(); // getting location of the application 
        getData(); //getting weather of value entered by the user
  }


  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
     
       title: Center(child: Text("Homepage")),
       actions: [
        IconButton(onPressed: 
        (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>HelpScreen()));
        }, icon: Icon(Icons.cloud)
        //icon at top that navigates to the help screen
        )
       ],

      ),
      body:Center(
        child: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100.0),
                    child: TextField(
                      onChanged: (value)
                      {
                        setState((){
                         textValue=value;
                        });
                      },
                      decoration: InputDecoration
                      (
                        hintText: "Enter your Location", 
                        //taking input from the user                   
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20.0,width: 20.0,),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  ElevatedButton(onPressed: (){
                    if(textValue.isNotEmpty)
                   { 
                    getData(); //getting weather of the entered address
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
                    //valueof button based on empty or not 
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
                    //displaying the weather in home page
              ],
            )
          ],),
        ),
      )
       
      );
  }
}

