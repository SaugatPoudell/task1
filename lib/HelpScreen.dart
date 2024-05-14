

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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/main.dart';


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
    return Scaffold(
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
       
    Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:Colors.blue,
        ),
        onPressed: ()
         async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool('Skipped',true);
        
          }
        ,
      
      child: Text('Skip'),),
    )
    ]
       )
    );
  }
}