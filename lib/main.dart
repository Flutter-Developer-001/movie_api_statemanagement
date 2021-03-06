import 'package:flurest/view/movie_list.dart';
import 'package:flurest/view/tv_show_list.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flurest',
      home: TvShowScreen(),
    );
  }
}
