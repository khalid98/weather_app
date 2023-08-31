import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/Style/app_colors.dart';
import 'package:weather_app/core/components/components.dart';
import 'package:weather_app/core/utils/constants.dart';
import 'package:weather_app/modules/Home/Presentation/components/dialy_weather_widget.dart';
import 'package:weather_app/modules/Home/Presentation/components/heading_details_widget.dart';
import 'package:weather_app/modules/Home/data/cubit/weatherby_city_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherbyCityCubit()..getCityWeather(city: "cairo"),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            title: SizedBox(
              width: ScreenUtil().screenWidth * 0.7,
              child: TextField(
                controller: _searchController,
                onSubmitted: (value) {
                  BlocProvider.of<WeatherbyCityCubit>(context)
                      .getCityWeather(city: value);
                },
                decoration: InputDecoration(
                  hintText: 'Search City',
                  //hintStyle: subTitleTextStyle(fontSize: 18),
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    size: 28,
                    color: AppColors.iconColor,
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                  key: const ValueKey('refresh'),
                  onPressed: () {
                    _searchController.clear();
                    BlocProvider.of<WeatherbyCityCubit>(context)
                        .getCityWeather(city: "cairo");
                  },
                  icon: Icon(
                    Icons.cancel,
                    size: 28,
                    color: AppColors.iconColor,
                  ))
            ],
          ),
          body: BlocListener<WeatherbyCityCubit, WeatherbyCityState>(
            listener: (context, state) {

            },
            child: BlocBuilder<WeatherbyCityCubit, WeatherbyCityState>(
              builder: (context, state) {
                if (state is WeatherbyCityLoading) {
                  return const Loading();
                }
                if (state is WeatherbyCitySuccess) {
                  return SafeArea(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: SizedBox(
                        width: ScreenUtil().screenWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              Constants.getAsset(
                                  state.weatherCityModel.weather!.first.icon!),
                              height: ScreenUtil().screenWidth * 0.3,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.lightBackgroundColor,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Text(
                                state.weatherCityModel.weather!.first.main ??
                                    "",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(fontSize: 16.sp),
                              ),
                            ),
                            gapHeight(height: 12),
                            Text(
                              "${state.weatherCityModel.name}, ${state.weatherCityModel.sys?.country}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  ?.copyWith(fontSize: 22.sp),
                            ),
                            gapHeight(height: 12),
                            Text(
                              '${state.weatherCityModel.main?.temp}° C',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  ?.copyWith(fontSize: 54.sp),
                            ),
                            gapHeight(height: 12),
                            Text(
                              '${state.weatherCityModel.main?.tempMax}° C / ${state.weatherCityModel.main?.tempMin}° C',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  ?.copyWith(fontSize: 15.sp),
                            ),
                            gapHeight(height: ScreenUtil().screenHeight * 0.05),
                            GridView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 2.5, crossAxisCount: 2),
                              children: [
                                HeadingDetailWidget(
                                    title: "Humidity",
                                    value:
                                        '${state.weatherCityModel.main?.humidity}%'),
                                HeadingDetailWidget(
                                    title: "Wind Speed",
                                    value:
                                        '${state.weatherCityModel.wind?.speed} m/s'),
                                HeadingDetailWidget(
                                    title: "Pressure",
                                    value:
                                        '${state.weatherCityModel.main?.pressure} hPa'),
                                HeadingDetailWidget(
                                    title: "Visibility",
                                    value:
                                        '${state.weatherCityModel.visibility! / 1000} km'),
                                HeadingDetailWidget(
                                    title: "Cloudiness",
                                    value:
                                        '${state.weatherCityModel.clouds?.all}%'),
                                HeadingDetailWidget(
                                    title: "Feels Like",
                                    value:
                                        '${state.weatherCityModel.main?.feelsLike}'),
                              ],
                            ),
                            DailyWeatherWidget(
                                dailyWeather: state.cityFiveForcastModel.list!),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                if (state is WeatherbyCityFailed) {
                  return Center(child: Text(state.error));
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        );
      }),
    );
  }
}
