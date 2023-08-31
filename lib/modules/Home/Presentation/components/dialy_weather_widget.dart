import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/components/components.dart';
import 'package:weather_app/core/utils/constants.dart';
import 'package:weather_app/modules/Home/models/five_forcast_model.dart';



class DailyWeatherWidget extends StatelessWidget {
  const DailyWeatherWidget({Key? key, required this.dailyWeather})
      : super(key: key);
  final List<ListElement> dailyWeather;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: dailyWeather.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const SizedBox();
            }
            return Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 12, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      Constants.getDayFromEpoch(dailyWeather[index].dt!),
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ),

                  Image.asset(
                    Constants.getAsset(
                        dailyWeather[index].weather!.first
                            .icon ?? ""),
                    width: ScreenUtil().screenWidth * 0.09,
                  ),
                  gapWidth(width: 32,),
                  Text(
                    '${dailyWeather[index].main?.tempMax}°',
                    style: Theme.of(context).textTheme.headline5
                        ?.copyWith(
                      color: Theme.of(context).colorScheme
                          .onSecondaryContainer,
                    ),
                  ),
                  gapWidth(width: 24,),
                  Text(
                    '${dailyWeather[index].main?.tempMin}°',
                    style: Theme.of(context).textTheme.headline6
                        ?.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

