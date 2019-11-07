import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:proto_pegas/screens/main_map_screen.dart';
import 'package:proto_pegas/services/location.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
//  Location location = Location();
  AnimationController controller;
  Animation animation;
  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.blue)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Timer(Duration(seconds: 2), () async {
        await getLocation();

        print('$latitude,$longitude');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return MainMapScreen(
                latitude: latitude,
                longitude: longitude,
              );
            },
          ),
        );
      }),
    );
  }

  Future<dynamic> getLocation() async {
    print('getting location');
    Location locationLocal = Location();
    print('entering getCurrentLocation');
    await locationLocal.getCurrentLocation();

    print('Get location $locationLocal ${locationLocal.latitude}');
    latitude = locationLocal.latitude;
    longitude = locationLocal.longitude;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.withOpacity(controller.value),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logoPegas',
                  child: Container(
                    child: Image.asset('images/pegascard.png'),
                    height: controller.value * 100,
                  ),
                ),
                Text(
                  'Pegascard',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            SpinKitRing(color: Colors.orange, size: 100.0),
          ],
        ),
      ),
    );
  }
}
