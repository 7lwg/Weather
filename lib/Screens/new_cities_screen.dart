import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/Cubits/delete%20button/delete_button_cubit.dart';
import 'package:weather_app/Cubits/get%20weather%20data%20cubit/get_weather_data_cubit.dart';
import 'package:weather_app/Screens/city_data_screen.dart';
import 'package:weather_app/data/Repository/get_weather_data_repo.dart';
import 'package:weather_app/functions/location.dart';
import 'package:weather_app/functions/style.dart';

class AddCity extends StatefulWidget {
  const AddCity({super.key});

  @override
  State<AddCity> createState() => _AddCityState();
}

class _AddCityState extends State<AddCity> {
  List<String> _cities = [];
  List<String> filteredCities = [];

  initstate() {}

  @override
  void initState() {
    super.initState();
    _loadCities();
  }

  Future<void> _loadCities() async {
    final String response = await rootBundle.loadString('assets/cities.json');
    final List<dynamic> data = json.decode(response);

    _cities = List<String>.from(data);
    filteredCities = _cities;

    // ignore: use_build_context_synchronously
    context.read<DeleteButtonCubit>().delete_button();
  }

  void _filterCities(String query) {
    filteredCities = _cities
        .where((city) => city.toLowerCase().contains(query.toLowerCase()))
        .toList();

    context.read<DeleteButtonCubit>().delete_button();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final landscape = mediaQuery.orientation == Orientation.landscape;
    // ignore: unused_local_variable
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
        backgroundColor: const Color.fromRGBO(50, 50, 160, 1),
        appBar: AppBar(
          toolbarHeight: (landscape)
              ? mediaQuery.size.height * (80 / 800)
              : mediaQuery.size.height * (60 / 800),
          backgroundColor: const Color.fromRGBO(50, 50, 160, 1),
          leading: Builder(builder: (context) {
            return (added_cities != 0)
                ? IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                  )
                : const SizedBox();
          }),
          automaticallyImplyLeading: false,
          title: Text(
            'Add city',
            style: (landscape)
                ? getTextWhiteHeader(context)
                : getTextWhiteHeader(context),
          ),
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(), // Prevents scrolling
          child: BlocBuilder<DeleteButtonCubit, DeleteButtonState>(
            builder: (context, state) {
              return Container(
                width: mediaQuery.size.width,
                height: mediaQuery.size.height,
                decoration: const BoxDecoration(
                    border: Border(
                  top: BorderSide(
                      color: Color.fromARGB(255, 203, 203, 203), width: 0.5),
                )),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: mediaQuery.size.width * 0.02,
                          bottom: mediaQuery.size.width * 0.02),
                      width: mediaQuery.size.width * 0.9,
                      child: TextFormField(
                        onChanged: (text) {
                          _filterCities(text);
                        },
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 15),
                            filled: true,
                            fillColor: Colors.grey,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            hintText: 'Search',
                            hintStyle: getTextWhite(context)),
                        style: getTextWhite(context),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(left: mediaQuery.size.width * 0.08),
                      width: mediaQuery.size.width,
                      height: (landscape)
                          ? mediaQuery.size.width * 0.05
                          : mediaQuery.size.height * 0.05,
                      color: Colors.white.withOpacity(0.08),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'RECOMMENDED CITIES',
                            style: getTextWhite(context),
                          )),
                    ),
                    // ignore: sized_box_for_whitespace
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          mainAxisExtent: (landscape)
                              ? mediaQuery.size.width * 0.08
                              : mediaQuery.size.height * 0.08,
                        ),
                        itemCount: filteredCities.length + 1,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              if (index == 0) {
                                Location = true;
                                await getLocation();

                                await getAddressFromLatLng(lat, long);

                                city_name = location_name;
                                // ignore: use_build_context_synchronously
                                await context
                                    .read<GetWeatherDataCubit>()
                                    .getWeatherData();
                                Location = false;
                                final prefs =
                                    await SharedPreferences.getInstance();

                                if (added_cities_names
                                        .contains(location_name) ==
                                    false) {
                                  added_cities++;

                                  added_cities_names.add(location_name);
                                  city_name = location_name;
                                  prefs.setString('city_name', city_name);
                                  prefs.setInt('added_cities', added_cities);
                                  prefs.setStringList(
                                      'added_cities_names', added_cities_names);
                                }

                                if (added_cities != 1) {
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pop();
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pop();
                                }
                                await Navigator.pushReplacement(
                                  // ignore: use_build_context_synchronously
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const CityDataScreen(),
                                  ),
                                );
                              } else {
                                if (added_cities_names
                                    .contains(filteredCities[index - 1])) {
                                  city_name = filteredCities[index - 1];
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString('city_name', city_name);
                                  // ignore: use_build_context_synchronously
                                  await context
                                      .read<GetWeatherDataCubit>()
                                      .getWeatherData();
                                  if (added_cities != 1) {
                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context).pop();
                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context).pop();
                                  }
                                  await Navigator.pushReplacement(
                                    // ignore: use_build_context_synchronously
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const CityDataScreen(),
                                    ),
                                  );
                                } else {
                                  added_cities++;
                                  city_name = filteredCities[index - 1];
                                  await context
                                      .read<GetWeatherDataCubit>()
                                      .getWeatherData();
                                  added_cities_names.add(Weather[0].address!);
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setInt('added_cities', added_cities);
                                  prefs.setStringList(
                                      'added_cities_names', added_cities_names);
                                  prefs.setString('city_name', city_name);

                                  if (added_cities != 1) {
                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context).pop();
                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context).pop();
                                  }
                                  await Navigator.pushReplacement(
                                    // ignore: use_build_context_synchronously
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const CityDataScreen(),
                                    ),
                                  );
                                }
                              }
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                    color: Color.fromARGB(255, 203, 203, 203),
                                    width: 0.5),
                                right: BorderSide(
                                    color: Color.fromARGB(255, 203, 203, 203),
                                    width: 0.5),
                              )),
                              child: Center(
                                  child: Text(
                                (index == 0)
                                    ? 'Current location'
                                    : filteredCities[index - 1],
                                style: getTextWhite(context),
                              )),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
