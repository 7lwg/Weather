// ignore_for_file: avoid_unnecessary_containers, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:weather_app/Cubits/humitity%20cubit/humidity_cubit.dart';
import 'package:weather_app/Screens/chosed_cities_screen.dart';
import 'package:weather_app/data/Repository/get_weather_data_repo.dart';
import 'package:weather_app/functions/style.dart';

class CityDataScreen extends StatelessWidget {
  const CityDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final landscape = mediaQuery.orientation == Orientation.landscape;
    // ignore: unused_local_variable
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    List<DateTime> dates = [
      DateTime.now(),
      DateTime.now().add(const Duration(days: 1)),
      DateTime.now().add(const Duration(days: 2)),
      DateTime.now().add(const Duration(days: 3)),
      DateTime.now().add(const Duration(days: 4))
    ];
    // ignore: non_constant_identifier_names
    List<String> printed_dates = [
      DateFormat('d MMM').format(dates[1]),
      DateFormat('d MMM').format(dates[2]),
      DateFormat('d MMM').format(dates[3]),
      DateFormat('d MMM').format(dates[4])
    ];

    // ignore: non_constant_identifier_names
    List<String> day_name = [
      DateFormat('EEEE').format(dates[1]),
      DateFormat('EEEE').format(dates[2]),
      DateFormat('EEEE').format(dates[3]),
      DateFormat('EEEE').format(dates[4])
    ];

    String convertTo12HourFormat(String time24Hour) {
      // Parse the input time string
      DateTime dateTime = DateFormat("HH:mm:ss").parse(time24Hour);

      // Format to 12-hour time with AM/PM
      String formattedTime = DateFormat("h:mm a").format(dateTime);

      return formattedTime;
    }

    void test() async {
      await getTimeInTimezone(Weather[0].timezone.toString());
    }

    test();

    double calculateSunPositionPercentage(
        String sunrise, String sunset, String actualNowTime) {
      // Define the date format
      DateFormat dateFormat = DateFormat("HH:mm:ss");

      // Parse the sunrise and sunset times
      DateTime sunriseTime = dateFormat.parse(sunrise);
      DateTime sunsetTime = dateFormat.parse(sunset);
      DateTime actualNow = dateFormat.parse(actualNowTime);

      // Adjust the date of sunrise and sunset to today
      sunriseTime = DateTime(actualNow.year, actualNow.month, actualNow.day,
          sunriseTime.hour, sunriseTime.minute, sunriseTime.second);
      sunsetTime = DateTime(actualNow.year, actualNow.month, actualNow.day,
          sunsetTime.hour, sunsetTime.minute, sunsetTime.second);

      // Calculate the total duration between sunrise and sunset
      Duration totalDuration = sunsetTime.difference(sunriseTime);

      // Calculate the duration from sunrise to now
      Duration elapsedDuration = actualNow.difference(sunriseTime);

      // Calculate the percentage
      double percentage =
          elapsedDuration.inSeconds / totalDuration.inSeconds * 100;

      // Ensure the percentage is between 0 and 100
      if (percentage < 0) {
        percentage = 0;
      } else if (percentage > 100) {
        percentage = 100;
      }

      return percentage;
    }

    String getCompassDirection(double degrees) {
      if (degrees >= 337.5 || degrees < 22.5) {
        return 'North';
      } else if (degrees >= 22.5 && degrees < 67.5) {
        return 'North-East';
      } else if (degrees >= 67.5 && degrees < 112.5) {
        return 'East';
      } else if (degrees >= 112.5 && degrees < 157.5) {
        return 'South-East';
      } else if (degrees >= 157.5 && degrees < 202.5) {
        return 'South';
      } else if (degrees >= 202.5 && degrees < 247.5) {
        return 'South-West';
      } else if (degrees >= 247.5 && degrees < 292.5) {
        return 'West';
      } else if (degrees >= 292.5 && degrees < 337.5) {
        return 'North-West';
      } else {
        return 'Invalid';
      }
    }

    // ignore: no_leading_underscores_for_local_identifiers
    void _onVisibilityChangedHumidity(VisibilityInfo info) {
      if (info.visibleFraction == 1.0) {
        percent = Weather[0].currentConditions!.humidity!;
        context.read<HumidityCubit>().humidityCubit();

        // ignore: avoid_print
        print("Container 1 is visible");
      } else if (info.visibleFraction == 0.0) {
        percent = 0.0;
        context.read<HumidityCubit>().humidityCubit();
        // ignore: avoid_print
        print("Container 1 is not visible");
      }
    }

    // ignore: no_leading_underscores_for_local_identifiers
    void _onVisibilityChangedSun(VisibilityInfo info) {
      if (info.visibleFraction == 1.0) {
        percent2 = calculateSunPositionPercentage(
            Weather[0].currentConditions!.sunrise!,
            Weather[0].currentConditions!.sunset!,
            Weather[0].currentConditions!.datetime!);
        context.read<HumidityCubit>().sunCubit();

        // ignore: avoid_print
        print("Container 2 is visible");
      } else if (info.visibleFraction == 0.0) {
        percent2 = 0.0;
        context.read<HumidityCubit>().sunCubit();
        // ignore: avoid_print
        print("Container 2 is not visible");
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(50, 50, 160, 1),
        appBar: AppBar(
          toolbarHeight: (landscape)
              ? mediaQuery.size.height * (80 / 800)
              : mediaQuery.size.height * (60 / 800),
          backgroundColor: const Color.fromRGBO(50, 50, 160, 1),
          leading: Builder(builder: (context) {
            return IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const Cities(),
                  ),
                );
              },
              icon: const Icon(
                Icons.location_city,
              ),
            );
          }),
          automaticallyImplyLeading: false,
          title: Text(
            city_name,
            style: (landscape)
                ? getTextWhiteHeader(context)
                : getTextWhiteHeader(context),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
              left: mediaQuery.size.width * 0.03,
              right: mediaQuery.size.width * 0.03,
            ),
            child: Column(
              children: [
                // ignore: sized_box_for_whitespace
                Container(
                  width: mediaQuery.size.width,
                  margin:
                      EdgeInsets.only(bottom: mediaQuery.size.height * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Opacity(
                              opacity: 0,
                              child: Text('\u00B0',
                                  style: getVeryLargText(context))),
                          Text(
                            '${Weather[0].currentConditions!.temp!.round()}\u00B0',
                            style: getVeryLargText(context),
                          ),
                        ],
                      ),
                      Text(
                        Weather[0].currentConditions!.conditions.toString(),
                        style: getTextWhite(context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${Weather[0].days![0].tempmax!.round()}\u00B0',
                            style: getTextWhite(context),
                          ),
                          Text(
                            '/${Weather[0].days![0].tempmin!.round()}\u00B0',
                            style: getTextGrey(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // ignore: sized_box_for_whitespace
                Container(
                  width: mediaQuery.size.width,
                  decoration: const BoxDecoration(
                      border: Border(
                    top: BorderSide(
                        color: Color.fromARGB(255, 203, 203, 203), width: 0.2),
                  )),
                  padding: EdgeInsets.only(top: mediaQuery.size.height * 0.05),
                  child: Column(
                    children: [
                      // ignore: sized_box_for_whitespace
                      Container(
                        width: mediaQuery.size.width,
                        height: (landscape)
                            ? mediaQuery.size.width * 0.20
                            : mediaQuery.size.height * 0.20,
                        child: ListView.builder(
                          itemCount: 24,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            // ignore: sized_box_for_whitespace
                            return Container(
                              height: (landscape)
                                  ? mediaQuery.size.width * 0.20
                                  : mediaQuery.size.height * 0.20,
                              margin: EdgeInsets.only(
                                  left: mediaQuery.size.width * 0.03,
                                  right: mediaQuery.size.width * 0.03),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    convertTo12HourFormat(Weather[0]
                                        .days![0]
                                        .hours![index]
                                        .datetime!),
                                    style: getTextsmallWhite(context),
                                  ),
                                  // ignore: sized_box_for_whitespace
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // ignore: sized_box_for_whitespace
                                          Container(
                                            width: (landscape)
                                                ? mediaQuery.size.height * 0.08
                                                : mediaQuery.size.width * 0.08,
                                            height: (landscape)
                                                ? mediaQuery.size.height * 0.08
                                                : mediaQuery.size.width * 0.08,
                                            child: FittedBox(
                                              child: (Weather[0]
                                                          .days![0]
                                                          .hours![index]
                                                          .icon ==
                                                      'clear-day')
                                                  ? Image.asset(
                                                      'assets/Clear.png',
                                                      scale: 15,
                                                    )
                                                  : (Weather[0]
                                                              .days![0]
                                                              .hours![index]
                                                              .icon ==
                                                          'clear-night')
                                                      ? Image.asset(
                                                          'assets/crescent-moon.png',
                                                          color: Colors.white,
                                                          scale: 15,
                                                        )
                                                      : (Weather[0]
                                                                  .days![0]
                                                                  .hours![index]
                                                                  .icon ==
                                                              'partly-cloudy-day')
                                                          ? Image.asset(
                                                              'assets/Partially_cloudy.png',
                                                              scale: 15,
                                                            )
                                                          : (Weather[0]
                                                                      .days![0]
                                                                      .hours![
                                                                          index]
                                                                      .icon ==
                                                                  'partly-cloudy-night')
                                                              ? Image.asset(
                                                                  'assets/partly-cloudy-night.png',
                                                                  color: Colors
                                                                      .white,
                                                                  scale: 15,
                                                                )
                                                              : (Weather[0]
                                                                          .days![
                                                                              0]
                                                                          .hours![
                                                                              index]
                                                                          .icon ==
                                                                      'rain')
                                                                  ? Image.asset(
                                                                      'assets/rain.png',
                                                                      color: Colors
                                                                          .white,
                                                                      scale: 15,
                                                                    )
                                                                  : (Weather[0]
                                                                              .days![
                                                                                  0]
                                                                              .hours![
                                                                                  index]
                                                                              .icon ==
                                                                          'cloudy')
                                                                      ? Image
                                                                          .asset(
                                                                          'assets/cloudy.png',
                                                                          color:
                                                                              Colors.white,
                                                                          scale:
                                                                              15,
                                                                        )
                                                                      : Image
                                                                          .asset(
                                                                          'assets/crescent-moon.png',
                                                                          scale:
                                                                              15,
                                                                        ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Opacity(
                                                  opacity: 0,
                                                  child: Text('\u00B0',
                                                      style: getTextsmallWhite(
                                                          context))),
                                              Text(
                                                '${Weather[0].days![0].hours![index].temp!.round()}\u00B0',
                                                style:
                                                    getTextsmallWhite(context),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      for (int i = 0; i < 4; i++)
                        Container(
                          width: mediaQuery.size.width,
                          height: (landscape)
                              ? mediaQuery.size.width * 0.08
                              : mediaQuery.size.height * 0.08,
                          decoration: BoxDecoration(
                              border: (i == 0)
                                  ? const Border(
                                      top: BorderSide(
                                          color: Color.fromARGB(
                                              255, 203, 203, 203),
                                          width: 0.2),
                                      bottom: BorderSide(
                                          color: Color.fromARGB(
                                              255, 203, 203, 203),
                                          width: 0.2),
                                    )
                                  : const Border(
                                      bottom: BorderSide(
                                          color: Color.fromARGB(
                                              255, 203, 203, 203),
                                          width: 0.2),
                                    )),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // ignore: sized_box_for_whitespace
                                  Container(
                                    width: mediaQuery.size.width * 0.6,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        (i == 0)
                                            ? Text(
                                                'Tomorrow, ${printed_dates[i]}',
                                                style: getTextWhite(context),
                                              )
                                            : Text(
                                                '${day_name[i]}, ${printed_dates[i]}',
                                                style: getTextWhite(context),
                                              ),

                                        // ignore: sized_box_for_whitespace
                                        Container(
                                          width: (landscape)
                                              ? mediaQuery.size.height * 0.1
                                              : mediaQuery.size.width * 0.1,
                                          height: (landscape)
                                              ? mediaQuery.size.height * 0.1
                                              : mediaQuery.size.width * 0.1,
                                          child: FittedBox(
                                            child: (Weather[0].days![i].icon ==
                                                    'clear-day')
                                                ? Image.asset(
                                                    'assets/Clear.png',
                                                    scale: 15,
                                                  )
                                                : (Weather[0].days![i].icon ==
                                                        'clear-night')
                                                    ? Image.asset(
                                                        'assets/crescent-moon.png',
                                                        color: Colors.white,
                                                        scale: 15,
                                                      )
                                                    : (Weather[0]
                                                                .days![i]
                                                                .icon ==
                                                            'partly-cloudy-day')
                                                        ? Image.asset(
                                                            'assets/Partially_cloudy.png',
                                                            scale: 15,
                                                          )
                                                        : (Weather[0]
                                                                    .days![i]
                                                                    .icon ==
                                                                'partly-cloudy-night')
                                                            ? Image.asset(
                                                                'assets/partly-cloudy-night.png',
                                                                color: Colors
                                                                    .white,
                                                                scale: 15,
                                                              )
                                                            : (Weather[0]
                                                                        .days![
                                                                            i]
                                                                        .icon ==
                                                                    'rain')
                                                                ? Image.asset(
                                                                    'assets/rain.png',
                                                                    color: Colors
                                                                        .white,
                                                                    scale: 15,
                                                                  )
                                                                : (Weather[0]
                                                                            .days![
                                                                                i]
                                                                            .icon ==
                                                                        'cloudy')
                                                                    ? Image
                                                                        .asset(
                                                                        'assets/cloudy.png',
                                                                        color: Colors
                                                                            .white,
                                                                        scale:
                                                                            15,
                                                                      )
                                                                    : Image
                                                                        .asset(
                                                                        'assets/crescent-moon.png',
                                                                        scale:
                                                                            15,
                                                                      ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${Weather[0].days![i + 1].tempmax!.round()}\u00B0',
                                        style: getTextWhite(context),
                                      ),
                                      Text(
                                        '/${Weather[0].days![i + 1].tempmin!.round()}\u00B0',
                                        style: getTextGrey(context),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                        ),
                      SizedBox(
                        height: (landscape)
                            ? mediaQuery.size.width * 0.02
                            : mediaQuery.size.height * 0.02,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Comfort level',
                              style: getTextBoldWhite(context))),
                      SizedBox(
                        height: (landscape)
                            ? mediaQuery.size.width * 0.02
                            : mediaQuery.size.height * 0.02,
                      ),
                      Container(
                        width: mediaQuery.size.width,
                        height: (landscape)
                            ? mediaQuery.size.width * 0.28
                            : mediaQuery.size.height * 0.28,
                        decoration: const BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 203, 203, 203),
                              width: 0.2),
                        )),
                        padding: EdgeInsets.only(
                            bottom: (landscape)
                                ? mediaQuery.size.width * 0.02
                                : mediaQuery.size.height * 0.02,
                            left: (landscape)
                                ? mediaQuery.size.height * 0.04
                                : mediaQuery.size.width * 0.04,
                            right: (landscape)
                                ? mediaQuery.size.height * 0.04
                                : mediaQuery.size.width * 0.04),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Humidity',
                                  style: getTextWhite(context),
                                ),
                                SizedBox(
                                  height: (landscape)
                                      ? mediaQuery.size.width * 0.02
                                      : mediaQuery.size.height * 0.02,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    // ignore: sized_box_for_whitespace
                                    child: Container(child: BlocBuilder<
                                        HumidityCubit, HumidityState>(
                                      builder: (context, state) {
                                        return VisibilityDetector(
                                          // ignore: prefer_const_constructors
                                          key: Key('visible-container1'),
                                          onVisibilityChanged:
                                              _onVisibilityChangedHumidity,
                                          child: SleekCircularSlider(
                                            appearance:
                                                CircularSliderAppearance(
                                              customColors: CustomSliderColors(
                                                trackColor: Colors.grey,
                                                progressBarColor: Colors.white,
                                                dotColor: Colors.blue,
                                              ),
                                              customWidths: CustomSliderWidths(
                                                trackWidth: 10,
                                                progressBarWidth: 10,
                                                handlerSize:
                                                    0, // hide the handler to mimic the static view
                                              ),
                                              startAngle: 130,
                                              angleRange: 280,
                                              infoProperties: InfoProperties(
                                                mainLabelStyle:
                                                    getTextWhiteHeader(context),
                                                modifier: (percentage) =>
                                                    '${Weather[0].currentConditions!.humidity!.round()}%',
                                              ),
                                            ),
                                            min: 0,
                                            max: 100,
                                            initialValue: percent,
                                          ),
                                        );
                                      },
                                    )),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Feels like  ',
                                      style: getTextGrey(context),
                                    ),
                                    Text(
                                      '${Weather[0].currentConditions!.feelslike!.round()}\u00B0',
                                      style: getTextWhite(context),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'UV index  ',
                                      style: getTextGrey(context),
                                    ),
                                    Text(
                                      Weather[0]
                                          .currentConditions!
                                          .uvindex!
                                          .round()
                                          .toString(),
                                      style: getTextWhite(context),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      // wind
                      SizedBox(
                        height: (landscape)
                            ? mediaQuery.size.width * 0.02
                            : mediaQuery.size.height * 0.02,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child:
                              Text('Wind', style: getTextBoldWhite(context))),
                      SizedBox(
                        height: (landscape)
                            ? mediaQuery.size.width * 0.02
                            : mediaQuery.size.height * 0.02,
                      ),
                      Container(
                        width: mediaQuery.size.width,
                        height: (landscape)
                            ? mediaQuery.size.width * 0.24
                            : mediaQuery.size.height * 0.24,
                        decoration: const BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 203, 203, 203),
                              width: 0.2),
                        )),
                        padding: EdgeInsets.only(
                            bottom: (landscape)
                                ? mediaQuery.size.width * 0.02
                                : mediaQuery.size.height * 0.02,
                            left: (landscape)
                                ? mediaQuery.size.height * 0.04
                                : mediaQuery.size.width * 0.04,
                            right: (landscape)
                                ? mediaQuery.size.height * 0.04
                                : mediaQuery.size.width * 0.04),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                // ignore: sized_box_for_whitespace
                                Container(
                                  height: (landscape)
                                      ? mediaQuery.size.width * 0.2
                                      : mediaQuery.size.height * 0.2,
                                  child: Lottie.asset(
                                    'assets/Windmill4.json',
                                  ),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Direction  ',
                                      style: getTextGrey(context),
                                    ),
                                    Text(
                                      getCompassDirection(Weather[0]
                                          .currentConditions!
                                          .winddir!),
                                      style: getTextWhite(context),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Speed  ',
                                      style: getTextGrey(context),
                                    ),
                                    Text(
                                      '${Weather[0].currentConditions!.windspeed!.round()} Km/h',
                                      style: getTextWhite(context),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: (landscape)
                            ? mediaQuery.size.width * 0.02
                            : mediaQuery.size.height * 0.02,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.nightlight_outlined,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text('Waning crescent',
                                  style: getTextBoldWhite(context)),
                            ],
                          )),
                      SizedBox(
                        height: (landscape)
                            ? mediaQuery.size.width * 0.02
                            : mediaQuery.size.height * 0.02,
                      ),
                      Container(
                        width: mediaQuery.size.width,
                        height: (landscape)
                            ? mediaQuery.size.width * 0.28
                            : mediaQuery.size.height * 0.28,
                        decoration: const BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 203, 203, 203),
                              width: 0.2),
                        )),
                        padding: EdgeInsets.only(
                            bottom: (landscape)
                                ? mediaQuery.size.width * 0.02
                                : mediaQuery.size.height * 0.02,
                            left: (landscape)
                                ? mediaQuery.size.height * 0.04
                                : mediaQuery.size.width * 0.04,
                            right: (landscape)
                                ? mediaQuery.size.height * 0.04
                                : mediaQuery.size.width * 0.04),
                        child: Column(
                          children: [
                            Text(
                              'Sunrise and Sunset',
                              style: getTextWhite(context),
                            ),
                            SizedBox(
                              height: (landscape)
                                  ? mediaQuery.size.width * 0.02
                                  : mediaQuery.size.height * 0.02,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    convertTo12HourFormat(
                                        Weather[0].currentConditions!.sunrise!),
                                    style: getTextWhite(context),
                                  ),
                                  Expanded(
                                    child: Container(child: BlocBuilder<
                                        HumidityCubit, HumidityState>(
                                      builder: (context, state) {
                                        return VisibilityDetector(
                                          key: const Key('visible-container2'),
                                          onVisibilityChanged:
                                              _onVisibilityChangedSun,
                                          child: SleekCircularSlider(
                                            appearance:
                                                CircularSliderAppearance(
                                              customColors: CustomSliderColors(
                                                trackColor: Colors.grey,
                                                progressBarColor: Colors.yellow,
                                                dotColor: Colors.blue,
                                              ),
                                              customWidths: CustomSliderWidths(
                                                trackWidth: 10,
                                                progressBarWidth: 10,
                                                handlerSize:
                                                    0, // hide the handler to mimic the static view
                                              ),
                                              startAngle: 180,
                                              angleRange: 180,
                                            ),
                                            innerWidget: (double value) {
                                              return Center(
                                                child: Text(localTimeNow,
                                                    style:
                                                        getTextWhite(context)),
                                              );
                                            },
                                            min: 0,
                                            max: 100,
                                            initialValue: percent2,
                                          ),
                                        );
                                      },
                                    )),
                                  ),
                                  Text(
                                    convertTo12HourFormat(
                                        Weather[0].currentConditions!.sunset!),
                                    style: getTextWhite(context),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

double percent = 0.0;
double percent2 = 0.0;
