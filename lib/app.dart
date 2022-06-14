import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:squadio/screens/home_screen/home_screen.dart';
import 'package:squadio/widgets/no_glow_scroll_behavior.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Squadio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.blue,
        splashColor: Colors.transparent,
        primaryColor: Colors.cyanAccent,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: ScrollConfiguration(
            behavior: NoGlowScrollBehavior(),
            child: child!,
          ),
        );
      },
      home: const HomeScreen(),
    );
  }
}


