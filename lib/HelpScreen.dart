import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:task1/MyHomePage.dart';
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
        //time duration that forwards to the another page Homepage after 5 seconds
      );
    });
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Skip>(create: (_) => Skip()),
    ],
      child: Scaffold(
        appBar: AppBar(title: Center(child: Text("We Show Weather ")),
        ),
         body:Stack(
           children:[ Container
                 (
            decoration:const BoxDecoration(
            image:DecorationImage(
              image:AssetImage('assets/images/1.png',
              //image of the border 
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
                //Determining skipped is pressed or not
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