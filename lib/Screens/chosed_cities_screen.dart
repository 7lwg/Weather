import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/Cubits/delete%20button/delete_button_cubit.dart';
import 'package:weather_app/Cubits/get%20weather%20data%20cubit/get_weather_data_cubit.dart';
import 'package:weather_app/Screens/new_cities_screen.dart';
import 'package:weather_app/Screens/city_data_screen.dart';
import 'package:weather_app/data/Repository/get_weather_data_repo.dart';
import 'package:weather_app/functions/style.dart';

class Cities extends StatefulWidget {
  const Cities({super.key});

  @override
  State<Cities> createState() => _CitiesState();
}

bool delete = false;

class _CitiesState extends State<Cities> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final landscape = mediaQuery.orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(50, 50, 160, 1),
      appBar: AppBar(
        toolbarHeight: (landscape)
            ? mediaQuery.size.height * (80 / 800)
            : mediaQuery.size.height * (60 / 800),
        backgroundColor: const Color.fromRGBO(50, 50, 160, 1),
        leading: Builder(builder: (context) {
          return BlocBuilder<DeleteButtonCubit, DeleteButtonState>(
            builder: (context, state) {
              return IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                color: Colors.white,
                onPressed: () {
                  if (delete == true) {
                    delete = false;
                    context.read<DeleteButtonCubit>().delete_button();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                icon: Icon(
                  (delete == true) ? Icons.close : Icons.arrow_back,
                ),
              );
            },
          );
        }),
        automaticallyImplyLeading: false,
        centerTitle: delete,
        title: Text(
          (delete == true) ? 'Edit cities' : 'Mange cities',
          style: (landscape)
              ? getTextWhiteHeader(context)
              : getTextWhiteHeader(context),
        ),
      ),
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
              border: Border(
            top: BorderSide(
                color: Color.fromARGB(255, 189, 176, 176), width: 0.7),
          )),
          child: BlocBuilder<DeleteButtonCubit, DeleteButtonState>(
            builder: (context, state) {
              return ListView.builder(
                  itemCount: added_cities,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onLongPress: () {
                        delete = true;
                        context.read<DeleteButtonCubit>().delete_button();
                      },
                      onTap: () async {
                        if (delete == false) {
                          city_name = added_cities_names[index];
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setString('city_name', city_name);
                          // ignore: use_build_context_synchronously
                          await context
                              .read<GetWeatherDataCubit>()
                              .getWeatherData();
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                          await Navigator.pushReplacement(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const CityDataScreen(),
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          left: (landscape)
                              ? mediaQuery.size.height * 0.04
                              : mediaQuery.size.width * 0.04,
                          right: (landscape)
                              ? mediaQuery.size.height * 0.04
                              : mediaQuery.size.width * 0.04,
                        ),
                        margin: EdgeInsets.only(
                            bottom: (landscape)
                                ? mediaQuery.size.height * 0.02
                                : mediaQuery.size.width * 0.02),
                        width: mediaQuery.size.width,
                        height: (landscape)
                            ? mediaQuery.size.width * 0.12
                            : mediaQuery.size.height * 0.12,
                        color: Colors.white.withOpacity(0.08),
                        child: Row(
                          children: [
                            // ignore: sized_box_for_whitespace
                            Container(
                              // color: Colors.red,
                              width: (landscape)
                                  ? mediaQuery.size.width * 0.45
                                  : mediaQuery.size.width * 0.45,
                              child: Text(
                                added_cities_names[index],
                                style: getTextWhiteHeader(context),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: (landscape)
                                  ? mediaQuery.size.width * 0.33
                                  : mediaQuery.size.width * 0.33,
                              margin: EdgeInsets.only(
                                  right: (delete == true) ? 10 : 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Opacity(
                                        opacity: 0,
                                        child: Text('\u00B0'),
                                      ),
                                      Text(
                                        (added_cities_names[index] == city_name)
                                            ? '${Weather[0].currentConditions!.temp!.round()}\u00B0'
                                            : '',
                                        style: getTextWhiteHeader(context),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    (added_cities_names[index] == city_name)
                                        ? Weather[0]
                                            .currentConditions!
                                            .conditions
                                            .toString()
                                        : '',
                                    style: getTextGrey(context),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            ),
                            (delete == true)
                                ? InkWell(
                                    onTap: () async {
                                      if (city_name ==
                                          added_cities_names[index]) {
                                        if (index == 0) {
                                          city_name = added_cities_names[1];
                                          await context
                                              .read<GetWeatherDataCubit>()
                                              .getWeatherData();
                                        } else {
                                          city_name = added_cities_names[0];
                                          await context
                                              .read<GetWeatherDataCubit>()
                                              .getWeatherData();
                                        }
                                      }
                                      added_cities--;
                                      added_cities_names.removeWhere(
                                          (element) =>
                                              element ==
                                              added_cities_names[index]);

                                      // ignore: use_build_context_synchronously
                                      context
                                          .read<DeleteButtonCubit>()
                                          .delete_button();
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setInt(
                                          'added_cities', added_cities);
                                      prefs.setStringList('added_cities_names',
                                          added_cities_names);
                                      prefs.setString('city_name', city_name);
                                    },
                                    child: Container(
                                      width: (landscape)
                                          ? mediaQuery.size.height * 0.08
                                          : mediaQuery.size.width * 0.08,
                                      height: (landscape)
                                          ? mediaQuery.size.height * 0.08
                                          : mediaQuery.size.width * 0.08,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.red,
                                      ),
                                      child: Icon(
                                        (delete == true)
                                            ? Icons.close
                                            : Icons.arrow_back,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : const SizedBox()
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: (landscape)
                ? EdgeInsets.all(mediaQuery.size.width * 0.03)
                : EdgeInsets.all(mediaQuery.size.height * 0.03),
            width: (landscape)
                ? MediaQuery.of(context).size.height * 0.6
                : MediaQuery.of(context).size.width * 0.6,
            height: (landscape)
                ? MediaQuery.of(context).size.height * 0.15
                : MediaQuery.of(context).size.height * 0.08,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 15,
                  ),
                ],
                color: const Color.fromARGB(255, 130, 126, 126),
                borderRadius: BorderRadius.circular(100)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        delete = false;
                        Navigator.push(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const AddCity(),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          // ignore: sized_box_for_whitespace
                          Container(
                            height: (landscape)
                                ? MediaQuery.of(context).size.width * 0.04
                                : MediaQuery.of(context).size.height * 0.04,
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Add city',
                            style: getTextsmallWhite(context),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        InkWell(
                          // ignore: sized_box_for_whitespace
                          child: Container(
                            height: (landscape)
                                ? MediaQuery.of(context).size.width * 0.04
                                : MediaQuery.of(context).size.height * 0.04,
                            child: const Icon(
                              Icons.widgets_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          'Weather widget',
                          style: getTextsmallWhite(context),
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ]),
    );
  }
}
