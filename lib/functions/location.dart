import 'package:geolocator/geolocator.dart';
import 'package:weather_app/data/Repository/get_weather_data_repo.dart';

Future<void> getLocation() async {
  LocationPermission permission;

  // Check if the user has granted permission
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return;
    }
  }

  // When we reach here, permissions are granted and we can continue
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  lat = position.latitude;
  long = position.longitude;
}
