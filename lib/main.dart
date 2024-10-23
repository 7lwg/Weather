// import 'dart:io';

// import 'dart:io';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:weather_app/Cubits/delete%20button/delete_button_cubit.dart';
import 'package:weather_app/Cubits/get%20weather%20data%20cubit/get_weather_data_cubit.dart';
import 'package:weather_app/Cubits/humitity%20cubit/humidity_cubit.dart';
import 'package:weather_app/Screens/splash_screen.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetWeatherDataCubit>(
          create: (BuildContext context) => GetWeatherDataCubit(),
        ),
        BlocProvider<HumidityCubit>(
          create: (BuildContext context) => HumidityCubit(),
        ),
        BlocProvider<DeleteButtonCubit>(
          create: (BuildContext context) => DeleteButtonCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
        builder: (context, Widget) => ResponsiveWrapper.builder(
            ClampingScrollWrapper.builder(context, Widget!),
            breakpoints: [
              const ResponsiveBreakpoint.resize(350, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(600, name: TABLET),
              const ResponsiveBreakpoint.resize(800, name: DESKTOP),
              const ResponsiveBreakpoint.resize(1200, name: 'XL'),
            ]),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
