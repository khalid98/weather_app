import 'package:flutter/material.dart';
import 'package:weather_app/modules/Home/Presentation/screens/home_screen.dart';


Route routes(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    default:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
  }
}
