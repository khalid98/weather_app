import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/Style/app_theme.dart';
import 'package:weather_app/core/api/dio_consumer.dart';
import 'package:weather_app/core/routes/routes.dart';

void main() {
  DioConsumer.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 840),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return SafeArea(
          top: false,
          left: false,
          right: false,
          bottom: false,
          child: MaterialApp(
            title: "Weather App",
            debugShowCheckedModeBanner: false,
            theme: AppStyle.apptheme,
            onGenerateRoute: routes,
            home: child,
          ),
        );
      },
    );
  }
}


