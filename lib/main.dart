// import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:task1/skip.dart';
import 'HelpScreen.dart';
import 'MyHomePage.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider<Skip>(create: (_) => Skip()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
           
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
        home:Consumer<Skip>(builder:(context,Skip,child)
        {
          var hasSkipped=Skip.Skipped;
          return hasSkipped?MyHomePage():HelpScreen();
          //if has skipped then go to homepage else to helpscreen
        }
        ),
        ),
    );
   
  }
}
