import 'package:intl/intl.dart';

class SunriseSunsetHelper {
  static String getFormattedTime(int timestamp) {
    int milliseconds = timestamp * 1000;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    return DateFormat.Hm().format(dateTime); // Format: HH:mm
  }
}
