import 'package:flutter/material.dart';
import 'package:section13/screens/location_screen.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:section13/services/weather.dart';
import 'package:section13/themes/light_mode.dart';
import 'package:section13/themes/dark_mode.dart';

class LoadingScreen extends StatefulWidget {
  late final dynamic locationWeather;
  late final Function(dynamic) updateWeatherCallback;
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherdata = await WeatherModel().getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherdata,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: LoadingAnimationWidget.dotsTriangle(
          size: 100,
          color: Colors.black87,
        ),
      ),
    );
  }
}
