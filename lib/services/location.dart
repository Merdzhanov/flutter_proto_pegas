import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;

  Future<void> getCurrentLocation() async {
    try {
      print('starting Geolocator');
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      print('$latitude,  $longitude in get current location');
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
