// import 'package:location/location.dart';

// // ignore: unnecessary_new
// Location location = new Location();

// bool? _serviceEnabled;

// PermissionStatus? _permissionGranted;

// LocationData? _locationData;

// Future<dynamic> getLocation() async {
//   _serviceEnabled = await location.serviceEnabled();
//   if (!_serviceEnabled!) _serviceEnabled = await location.requestService();

//   _permissionGranted = await location.hasPermission();
//   if (_permissionGranted == PermissionStatus.denied) {
//     _permissionGranted = await location.requestPermission();
//   }
//   _locationData = await location.getLocation();
//   return _locationData;
// }
//*******
// import 'package:geolocator/geolocator.dart';
// import 'package:weather_app/data/Repository/get_weather_data_repo.dart';

// Future<Position> getCurrentLocation() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   // Check if location services are enabled
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     // Location services are not enabled, don't continue
//     return Future.error('Location services are disabled.');
//   }

//   // Check for location permissions
//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       // Permissions are denied, don't continue
//       return Future.error('Location permissions are denied');
//     }
//   }

//   if (permission == LocationPermission.deniedForever) {
//     // Permissions are denied forever, handle appropriately
//     return Future.error(
//         'Location permissions are permanently denied, we cannot request permissions.');
//   }

//   // When permissions are granted, get the current position
//   return await Geolocator.getCurrentPosition();
// }

// void getLocation() async {
//   try {
//     Position position = await getCurrentLocation();
//     lat = position.latitude;
//     long = position.longitude;
//     print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
//   } catch (e) {
//     print(e);
//   }
// }

// import 'package:geolocator/geolocator.dart';
// import 'package:weather_app/data/Repository/get_weather_data_repo.dart';

// Future<Position> _getCurrentLocation() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   // Check if location services are enabled
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     return Future.error('Location services are disabled.');
//   }

//   // Check for location permissions
//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       return Future.error('Location permissions are denied');
//     }
//   }

//   if (permission == LocationPermission.deniedForever) {
//     return Future.error(
//         'Location permissions are permanently denied, we cannot request permissions.');
//   }

//   // When permissions are granted, get the current position
//   return await Geolocator.getCurrentPosition();
// }

// getLocation() async {
//   Position position = await _getCurrentLocation();
//   lat = position.latitude;
//   long = position.longitude;

//   // setState(() {
//   //   _locationMessage =
//   //       'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
//   // });
// }

import 'package:geolocator/geolocator.dart';
import 'package:weather_app/data/Repository/get_weather_data_repo.dart';

Future<void> getLocation() async {
  LocationPermission permission;

  // print('1 //**');
  // Check if the user has granted permission
  permission = await Geolocator.checkPermission();
  // print('2 //**');
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return;
    }
  }
  // print('3 //**');

  // When we reach here, permissions are granted and we can continue
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  // print('4 //**');
  lat = position.latitude;
  long = position.longitude;
  // setState(() {
  //   location =
  //       'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
  // });
}
