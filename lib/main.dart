import 'package:flutter/material.dart';
import 'package:proto_pegas/screens/splash_screen.dart';
import 'package:proto_pegas/screens/main_map_screen.dart';
import 'package:proto_pegas/screens/qr_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(
          textTheme: TextTheme(
            body1: TextStyle(color: Colors.black54),
          ),
        ),
        initialRoute: SplashScreen.id,
//        initialRoute: MainMapScreen.id,
        routes: {
          SplashScreen.id: (context) => SplashScreen(),
          MainMapScreen.id: (context) => MainMapScreen(),
          QrScreen.id: (context) => QrScreen(),
        });
  }
}
