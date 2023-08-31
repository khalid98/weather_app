import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/Style/app_colors.dart';

class HeadingDetailWidget extends StatelessWidget {
  final String title;
  final String value;
  final String unit;

  const HeadingDetailWidget({
    Key? key,
    required this.title,
    required this.value,
    this.unit = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: AppColors.lightBackgroundColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Text(
              title,
              style: theme.textTheme.headline1
                  ?.copyWith(
              fontSize: 20.sp),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: value,
                    style: theme.textTheme.headline1
                        ?.copyWith(fontSize: 18.sp),
                  ),
                  TextSpan(
                    text: ' $unit',
                    style: theme.textTheme.headline2
                        ?.copyWith(fontSize: 16.sp),
                  ),
                ])),
          ),
        ],
      ),
    );
  }
}
