import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/Cubits/get%20weather%20data%20cubit/get_weather_data_cubit.dart';
import 'package:weather_app/Screens/new_cities_screen.dart';
import 'package:weather_app/Screens/city_data_screen.dart';
import 'package:weather_app/data/Repository/get_weather_data_repo.dart';
import 'package:weather_app/functions/style.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

Future<void> getLocalData() async {
  var prefs = await SharedPreferences.getInstance();
  added_cities = prefs.getInt('added_cities') ?? 0;
  added_cities_names = prefs.getStringList('added_cities_names') ?? [];
  city_name = prefs.getString('city_name') ?? '';
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initFunction() async {
      await getLocalData();

      // ignore: use_build_context_synchronously
      await context.read<GetWeatherDataCubit>().getWeatherData();

      if (added_cities == 0) {
        await Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const AddCity(),
          ),
        );
      } else {
        await Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const CityDataScreen(),
          ),
        );
      }
    }

    initFunction();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final landscape = mediaQuery.orientation == Orientation.landscape;
    return Scaffold(
      body: Container(
        width: mediaQuery.size.width,
        height: mediaQuery.size.height,
        color: const Color.fromRGBO(50, 50, 160, 1),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Container(
                width: mediaQuery.size.width,
                margin: EdgeInsets.only(
                    left: mediaQuery.size.width * (20 / 360),
                    right: mediaQuery.size.width * (20 / 360),
                    bottom: mediaQuery.size.height * (20 / 800)),
                child: Text(
                  "Hello",
                  style: getSplashScreen(context),
                ),
              ),
              Container(
                width: mediaQuery.size.width,
                height: (landscape)
                    ? mediaQuery.size.height * 1 / 2
                    : mediaQuery.size.width * 1 / 2,
                margin: EdgeInsets.only(
                    left: mediaQuery.size.width * (20 / 360),
                    right: mediaQuery.size.width * (20 / 360)),
                child: Image.asset(
                  "assets/Clear.png",
                  fit: BoxFit.fitHeight,
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Weather's App",
                        style: getTextWhite(context),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
