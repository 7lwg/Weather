// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
// import 'package:location/location.dart';
import 'package:weather_app/data/Models/cities_model.dart';
import 'package:weather_app/data/Models/get_weather_data_model.dart';
// import 'package:weather_app/functions/location.dart';

// ignore: non_constant_identifier_names, unused_element
List<City> _cities = [];
// ignore: non_constant_identifier_names
List<WeatherDataModel> Weather = [];
String url = "";
// ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names
var weather_response;
DateTime startDate = DateTime.now();
DateTime endDate = DateTime.now().add(const Duration(days: 4));
DateFormat formatter = DateFormat('yyyy-MM-d');
String startDateFormat = formatter.format(startDate);
String endDateFormat = formatter.format(endDate);
// ignore: non_constant_identifier_names
int hours_now = DateTime.now().hour;
// ignore: non_constant_identifier_names
String city_name = '';
// ignore: non_constant_identifier_names
int added_cities = 1;
// ignore: non_constant_identifier_names
List<String> added_cities_names = [];
double lat = 0.0;
double long = 0.0;
// ignore: non_constant_identifier_names
bool Location = false;
// ignore: non_constant_identifier_names
String location_name = '';
// List<int> added_cities_temp = [];

String localTimeNow = '';
// List<String> added_cities_condition = [];
// int hours_now = 1;

class GetWeatherDataRepo {
  // ignore: non_constant_identifier_names
  Future<String?> GetWeatherData() async {
    try {
      // if (city_name == '') {
      //   // print('startDateFormat ' + startDateFormat + '//**');
      //   // print('endDateFormat ' + endDateFormat + '//**');
      //   // print('object1 //**');
      //   print('1 //**');
      //   weather_response = await http.get(
      //     Uri.parse(
      //         'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/port%20said/$startDateFormat/$endDateFormat?unitGroup=metric&include=current%2Chours&key=J8ZQ8CHH8ZSPST9AE4ZFLS8SV&contentType=json'
      //         // 'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/بورسعيد/$startDateFormat/$endDateFormat?unitGroup=metric&include=current%2Chours&key=J8ZQ8CHH8ZSPST9AE4ZFLS8SV&contentType=json'
      //         // 'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/port said/$startDateFormat/$endDateFormat?unitGroup=metric&include=current%2Chours&key=J8ZQ8CHH8ZSPST9AE4ZFLS8SV&contentType=json'
      //         ),
      //   );
      // } else {
      if (Location == false) {
        // print('object2 //**');
        // print(city_name + ' test ' + '//**');
        // print('2 //**');
        // print(
        //     'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/$city_name/$startDateFormat/$endDateFormat?unitGroup=metric&include=current%2Chours&key=J8ZQ8CHH8ZSPST9AE4ZFLS8SV&contentType=json //**');
        weather_response = await http.get(
          Uri.parse(
              'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/$city_name/$startDateFormat/$endDateFormat?unitGroup=metric&include=current%2Chours&key=J8ZQ8CHH8ZSPST9AE4ZFLS8SV&contentType=json'),
        );
      } else {
        // print('3 //**');
        // print(
        //     'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/$lat,$long/$startDateFormat/$endDateFormat?unitGroup=metric&include=current%2Chours&key=J8ZQ8CHH8ZSPST9AE4ZFLS8SV&contentType=json //**');
        weather_response = await http.get(
          Uri.parse(
              'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/$lat,$long/$startDateFormat/$endDateFormat?unitGroup=metric&include=current%2Chours&key=J8ZQ8CHH8ZSPST9AE4ZFLS8SV&contentType=json'
              // 'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/31.245,32.318/$startDateFormat/$endDateFormat?unitGroup=metric&include=current%2Chours&key=J8ZQ8CHH8ZSPST9AE4ZFLS8SV&contentType=json'
              ),
        );
        Location = false;
      }
      // }
      if (weather_response.statusCode == 200) {
        Map<String, dynamic> decodedResponse =
            jsonDecode(weather_response.body);
        if (decodedResponse.isNotEmpty) {
          try {
            // print('12 //**');
            WeatherDataModel weatherData =
                WeatherDataModel.fromJson(decodedResponse);
            // print('123 //**');
            Weather = [weatherData];
            // print('${Weather.length}//**');
            return 'weatherList'; // Return the list of weather data
          } catch (e) {
            throw Exception('Failed to parse weather data');
          }
        } else {
          throw Exception('Empty response from API');
        }
      } else {
        return null;
      }
    } catch (error) {
      // ignore: prefer_interpolation_to_compose_strings
      // print(error.toString() + ' 123//**');
      return null;
    }
  }

  // ignore: unused_element
  Future<void> _loadCities() async {
    final String response =
        await rootBundle.loadString('assets/your_file.json');
    final List<dynamic> data = json.decode(response);

    _cities = data.map((city) => City.fromJson(city)).toList();
    // await getAddressFromLatLng(lat, long);
    // print(location_name + '//**');
  }
}

Future<void> getAddressFromLatLng(double lat, double lng) async {
  final url =
      'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lng&zoom=18&addressdetails=1';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data['address'] != null) {
      // print('yes yes //**');
      // final address = data['display_name'];
      // location_name = data['display_name'];
      final address = data['address'];
      location_name = address['city'] ??
          address['town'] ??
          address['village'] ??
          'City not found';
      // print('location_name: $location_name//**');
      // return address;
    } else {
      // return 'No address found';
    }
  } else {
    throw Exception('Failed to load data');
  }
}

Future<String> getTimeInTimezone(String timezone) async {

  // Construct the API URL
  var url =
      Uri.parse('https://timeapi.io/api/Time/current/zone?timeZone=$timezone');

  // Make the HTTP request
  var response = await http.get(url);  
  if (response.statusCode == 200) {
    // Parse the JSON response

    var data = jsonDecode(response.body);

    // Extract the current datetime
    String dateTime = data['dateTime'];

    // Convert the datetime string to a DateTime object
    DateTime now = DateTime.parse(dateTime);

    // Format the DateTime to a readable format
    localTimeNow = DateFormat('h:mm a').format(now);
    // return 'Current time in $timezone: $formattedTime';
    return '';
  } else {
    throw Exception('Failed to load time for $timezone');
  }
}


// class GetWeatherDataRepo {
//   // ignore: non_constant_identifier_names
//   Future<String?> GetWeatherData() async {
//     try {
//       if (city_name == '') {
//         print('Fetching weather data with default city...');
//         weather_response = await http.get(
//           Uri.parse(
//               'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/New York/${startDateFormat}/${endDateFormat}?unitGroup=metric&include=current%2Chours&key=J8ZQ8CHH8ZSPST9AE4ZFLS8SV&contentType=json'),
//         );
//       } else {
//         print('Fetching weather data for $city_name...');
//         weather_response = await http.get(
//           Uri.parse(
//               'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/${city_name}/${startDateFormat}/${endDateFormat}?unitGroup=metric&include=current%2Chours&key=J8ZQ8CHH8ZSPST9AE4ZFLS8SV&contentType=json'),
//         );
//       }

//       if (weather_response.statusCode == 200) {
//         print('Response received successfully');  
//         Map<String, dynamic> decodedResponse =
//             jsonDecode(weather_response.body);

//         if (decodedResponse.isNotEmpty) {
//           try {
//             WeatherDataModel weatherData =
//                 WeatherDataModel.fromJson(decodedResponse);
//             Weather = [weatherData];
//             print('Weather data parsed successfully');
//             return 'weatherList'; // Return the list of weather data
//           } catch (e) {
//             print('Error parsing weather data: ${e.toString()}');
//             throw Exception('Failed to parse weather data');
//           }
//         } else {
//           print('Empty response from API');
//           throw Exception('Empty response from API');
//         }
//       } else {
//         print('Failed to fetch weather data: ${weather_response.statusCode}');
//         return null;
//       }
//     } catch (error) {
//       print('An error occurred: ${error.toString()}');
//       return null;
//     }
//   }

//   Future<void> _loadCities() async {
//     try {
//       final String response =
//           await rootBundle.loadString('assets/your_file.json');
//       final List<dynamic> data = json.decode(response);
//       print('Cities data loaded successfully');
//       _cities = data.map((city) => City.fromJson(city)).toList();
//     } catch (error) {
//       print('An error occurred while loading cities: ${error.toString()}');
//     }
//   }
// }
