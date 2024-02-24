import 'package:flutter/material.dart';
import 'package:section13/screens/city_screen.dart';
import 'package:section13/screens/settings_page.dart';
import 'package:section13/services/weather.dart';
import '../utilities/constants.dart';

class MyDrawer extends StatefulWidget {
  final Function(dynamic) onWeatherDataFromCityName;
  final Function(dynamic) onLocationSelected;
  const MyDrawer({
    super.key,
    required this.onLocationSelected,
    required this.onWeatherDataFromCityName,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  WeatherModel weather = WeatherModel();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          DrawerHeader(
            child: Icon(
              Icons.wb_sunny_rounded,
              size: 40,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, top: 25),
            child: ListTile(
              title: const Text('MY  LOCATION'),
              leading: const Icon(Icons.near_me),
              onTap: () async {
                var weatherData = await weather.getLocationWeather();
                widget.onLocationSelected(weatherData);
                Navigator.pop(context);

                /// this is from where i want to pass data on
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 18),
            child: ListTile(
              title: const Text('OTHER  LOCATIONS'),
              leading: const Icon(
                Icons.location_city_outlined,
              ),
              onTap: () async {
                var typedName = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CityScreen(),
                  ),
                );
                if (typedName != null) {
                  var weatherData = await weather.getCityWeather(typedName);

                  /// from here
                  widget.onWeatherDataFromCityName(weatherData);
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 18),
            child: ListTile(
              title: const Text(
                'SETTINGS',
              ),
              leading: const Icon(Icons.settings),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
            ),
          ),
          // const Divider(
          //   thickness: 1.0,
          //   height: 40.0, // Optional, adjust as needed
          //   indent: 40.0, // Optional, indent from the left
          //   endIndent: 40.0, // Optional, indent from the right
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 300.0, left: 25),
            child: ListTile(
              title: Text(
                'DEVELOPED BY RITIK SHARMA',
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w200,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
