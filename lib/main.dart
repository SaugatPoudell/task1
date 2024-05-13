// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {


  const MyHomePage({super.key, required this.title});

  final String title;
  

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 String textValue="";
//  double _currentLocation=0.0;
//  double latitude=position.latitude;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLocation();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
       title: Text("HomePage"),
      ),
      body: Center(
        child: Container(
        
          child: Column(children: [
            // Row(
            //   children: [
            //     Text("Enter Location"),
            //   ],
            // ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value)
                    {
                      setState(() {
                       textValue=value;
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
            Row(
              children: [
                ElevatedButton(onPressed: (){}, child: Text
                (
                  textValue.isEmpty?"Save":"Update",
                ))
              ],
            )
        
            //  TextField(
            // decoration:InputDecoration
            // (
            // contentPadding: EdgeInsets.all(10.0)
            // ),
            // ),
          
          ],),
        ),
      )
       
      );
  }



Future<Position>_getLocation() async {
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  print(position);
  return position;

}

Future<void> getData() async
{
  Position position =await _getLocation();
  print(position);
  final response = await http.get(Uri.parse("http://api.weatherapi.com/v1/current.json?key=1bc0383d81444b58b1432929200711&q=${position.latitude},${position.longitude}"));
 
 if(response.statusCode==200)
 {
print(response.body);
 } 
else
{
  print("Failed to load");
}
}

}
  // class HelpScreen extends StatefulWidget {
  //   const HelpScreen({super.key});
  
  //   @override
  //   State<HelpScreen> createState() => _HelpScreenState();
  // }
  
  // class _HelpScreenState extends State<HelpScreen> {
  //   @override
  //   Widget build(BuildContext context) {
  //     return Scaffold(
  //       appBar: AppBar
  //       (
  //         // title: Text("We show Weather for you"),
  //       ),

  //     );
  //   }
  // }