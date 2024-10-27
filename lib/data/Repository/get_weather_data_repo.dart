// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/data/Models/cities_model.dart';
import 'package:weather_app/data/Models/get_weather_data_model.dart';

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

String localTimeNow = '';

class GetWeatherDataRepo {
  // ignore: non_constant_identifier_names
  Future<String?> GetWeatherData() async {
    try {
      if (Location == false) {
        weather_response = await http.get(
          Uri.parse(
              'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/$city_name/$startDateFormat/$endDateFormat?unitGroup=metric&include=current%2Chours&key=J8ZQ8CHH8ZSPST9AE4ZFLS8SV&contentType=json'),
        );
      } else {
        weather_response = await http.get(
          Uri.parse(
              'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/$lat,$long/$startDateFormat/$endDateFormat?unitGroup=metric&include=current%2Chours&key=J8ZQ8CHH8ZSPST9AE4ZFLS8SV&contentType=json'),
        );
        Location = false;
      }
      if (weather_response.statusCode == 200) {
        Map<String, dynamic> decodedResponse =
            jsonDecode(weather_response.body);
        if (decodedResponse.isNotEmpty) {
          try {
            WeatherDataModel weatherData =
                WeatherDataModel.fromJson(decodedResponse);

            Weather = [weatherData];

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
      return null;
    }
  }

  // ignore: unused_element
  Future<void> _loadCities() async {
    final String response =
        await rootBundle.loadString('assets/your_file.json');
    final List<dynamic> data = json.decode(response);

    _cities = data.map((city) => City.fromJson(city)).toList();
  }
}

Future<void> getAddressFromLatLng(double lat, double lng) async {
  final url =
      'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lng&zoom=18&addressdetails=1';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data['address'] != null) {
      final address = data['address'];
      location_name = address['city'] ??
          address['town'] ??
          address['village'] ??
          'City not found';
    }
  } else {
    throw Exception('Failed to load data');
  }
}

Future<String> getTimeInTimezone(String timezone) async {
  var url =
      Uri.parse('https://timeapi.io/api/Time/current/zone?timeZone=$timezone');

  var response = await http.get(url);
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    String dateTime = data['dateTime'];

    DateTime now = DateTime.parse(dateTime);

    localTimeNow = DateFormat('h:mm a').format(now);
    return '';
  } else {
    throw Exception('Failed to load time for $timezone');
  }
}
