import 'package:assignment_2/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Page',
      home: MainPage(),
      theme: ThemeData.light().copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          listTileTheme: const ListTileThemeData(iconColor: Colors.black87),
          iconTheme: const IconThemeData(color: Colors.black87),
          backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
          dividerTheme: const DividerThemeData(thickness: 1.5),
          inputDecorationTheme: const InputDecorationTheme(
              errorStyle: TextStyle(fontSize: 12),
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              border: OutlineInputBorder())),
      darkTheme: ThemeData.dark().copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          listTileTheme: const ListTileThemeData(iconColor: Colors.white),
          textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.white)),
          iconTheme: const IconThemeData(color: Colors.white),
          dividerTheme: const DividerThemeData(thickness: 1.5),
          inputDecorationTheme: const InputDecorationTheme(
              errorStyle: TextStyle(fontSize: 12),
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              border: OutlineInputBorder())),
    );
  }
}
