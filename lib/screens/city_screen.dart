import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:section13/themes/theme_provider.dart';
import '../utilities/constants.dart';
import 'location_screen.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late String cityName = '';
  //is dark mode

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkmode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('OTHER LOCATIONS'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              const Align(
                alignment: Alignment.topLeft,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20.0, 40, 20, 20),
                child: TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.onSecondary,
                      icon: Icon(
                        Icons.location_searching,
                        size: 30,
                      ),
                      hintText: "Search here",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      )),
                  onChanged: (value) {
                    cityName =
                        value; // Print the value entered in the TextField
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 18.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSecondary,
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: [
                        /// darker shadow on bottom left
                        BoxShadow(
                            color: isDarkMode
                                ? Colors.black
                                : Colors.grey.shade500,
                            blurRadius: 15,
                            offset: const Offset(4, 4)),

                        /// lighter shadow on bottom right
                        BoxShadow(
                            color: isDarkMode
                                ? Colors.grey.shade800
                                : Colors.white,
                            blurRadius: 15,
                            offset: const Offset(4, 4)),
                      ]),
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, cityName);

                      Navigator.pop(context);
                    },
                    child: Text(
                      'Get Weather',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
