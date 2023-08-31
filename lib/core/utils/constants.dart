import 'package:intl/intl.dart';

class Constants {
  static String apiKey = "b3fd71cde9d0e9908472183a1ce4d4a0";


  static String getAsset(String code) {
    return "assets/images/$code.png";
  }
  static String getDayFromEpoch(int dt) {
    final curDt = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
    final day = DateFormat('EEEE').format(curDt);
    return day;
  }
}
