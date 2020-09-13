import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/screens/homepage.dart';
import 'package:todo/screens/taskpage.dart';

import 'apputils.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: AppUtils.homePage,
      routes:{
        AppUtils.homePage: (context) => HomePage(),
        AppUtils.taskPage: (context) => TaskPage(),
      },
    )
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        initialRoute: AppUtils.homePage,
        routes:{
          AppUtils.homePage: (context) => HomePage(),
          AppUtils.taskPage: (context) => TaskPage(),
        },

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoSansTextTheme(
          Theme.of(context).textTheme,
        )
      ),
    );
  }
}
