import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/MyHomePage.dart';
import 'package:task1/main.dart';
import 'skip.dart';


class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5),()
    {
       Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    });
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Skip>(create: (_) => Skip()),
    ],
      child: Scaffold(
        appBar: AppBar(title: Text("We Show Weather "),
        ),
         body:Stack(
           children:[ Container
                 (
            decoration:const BoxDecoration(
            image:DecorationImage(
              image:AssetImage('assets/images/1.png',
              ),
              scale:1.0,
              fit:BoxFit.cover,
            ),
                 
                 )
               
               ),
         
      Consumer<Skip>(
        builder: (context,Skip,child)
        {
          return Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:Colors.blue,
            ),
            onPressed: ()
            {
                Skip.SkippedSender();
            },
          child: Text('Skip'),),
        );
        },
        
      )
      ]
         )
      ),
    );
  }
}