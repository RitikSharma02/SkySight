import 'package:flutter/material.dart';
import 'package:section13/screens/my_drawer.dart';
import 'package:section13/utilities/date_time_helper.dart';
import '../utilities/constants.dart';
import 'package:section13/services/sunrise_sunset.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, required this.locationWeather});

  final dynamic locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late String cityName = '';
  late String description = '';
  late int temperature = 0;
  late int feelsLikeTemperature = 0;
  late int sunrise = 0;
  late int sunset = 0;
  late double wind = 0;
  late int humidity = 0;
  late int visibility = 0;
  late int condition = 0;
  late String formattedSunrise = '';
  late String formattedSunset = '';
  double visibilityInKm = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.locationWeather);
    print(description);
  }

  /// this is the update UI method i want to pass data in
  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        cityName = ':(';
        description = 'couldn\'t fetch the data';

        return;
      }

      ///temperature
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();

      ///cityName
      cityName = weatherData['name'];

      ///description cloudy, sunny , etc
      description = weatherData['weather'][0]['description'];

      /// feels like temperature
      double fltemp = weatherData['main']['feels_like'];
      feelsLikeTemperature = fltemp.toInt();

      /// sunrise and sunset
      sunrise = weatherData['sys']['sunrise'];
      sunset = weatherData['sys']['sunset'];

      /// Format the DateTime objects to display the time
      formattedSunrise = SunriseSunsetHelper.getFormattedTime(sunrise);
      formattedSunset = SunriseSunsetHelper.getFormattedTime(sunset);

      ///  wind
      wind = weatherData['wind']['speed'];

      ///  humidity
      humidity = weatherData['main']['humidity'];

      ///  Visiblity
      visibility = weatherData['visibility'];
      visibilityInKm = visibility / 1000;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          cityName,
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontSize: 30,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      drawer: MyDrawer(
        onLocationSelected: updateUI,
        onWeatherDataFromCityName: updateUI,
      ),

      /////////

      body: Container(
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  margin: EdgeInsets.only(left: 90, right: 90),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  height: 40,
                  width: 40,
                  child: Center(
                    child: Text(
                      '${DateTimeHelper.getDayOfWeek(DateTime.now().weekday)}, ${DateTime.now().day} ${DateTimeHelper.getMonth(DateTime.now().month)}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.background,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    '$temperature°',
                    style: TextStyle(
                      fontSize: 140,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 25.0),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Daily Summary \n',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      TextSpan(
                        text:
                            '\n Temperature is $temperature°C, but feels like $feelsLikeTemperature°C\n',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      TextSpan(
                        text:
                            '\n Sunrise : $formattedSunrise, Sunset : $formattedSunset',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                margin:
                    EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 35),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).colorScheme.inversePrimary),
                // Container color
                padding:
                    EdgeInsets.only(left: 8.0, right: 8, top: 8, bottom: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.air,
                            size: 70,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          Text(
                            '$wind Km/h',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'Wind',
                            style: TextStyle(
                              fontSize: 11,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.water_drop,
                            size: 70,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            "$humidity %",
                            style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                          Text(
                            'Humidity',
                            style: TextStyle(
                              fontSize: 11,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.remove_red_eye_outlined,
                            size: 70,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          Text(
                            "$visibilityInKm km",
                            style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                          Text(
                            'Visibility',
                            style: TextStyle(
                              fontSize: 11,
                              color: Theme.of(context).colorScheme.onSecondary,
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
    );
  }
}
