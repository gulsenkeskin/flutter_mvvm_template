import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

void main() {
  runApp(Easylocalization(child:MyApp(), supportedLocales:null,path:null));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This view is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text(""),),
        body: Center(
          child: Container(
            child: Text(""),
          ),
        ),
      )
    );
  }
}
