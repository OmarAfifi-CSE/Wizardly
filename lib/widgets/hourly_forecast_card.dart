import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HourlyForecastCard extends StatelessWidget {
  final String time;
  final String iconUrl;
  final String temperature;
  final Color backgroundColor;
  final Color textColor;

  const HourlyForecastCard({
    super.key,
    required this.time,
    required this.iconUrl,
    required this.temperature,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Text(
            time,
            style: TextStyle(color: textColor, fontSize: 16.sp),
          ),
          Positioned(
            bottom: 0,
            top: 0,
            child: Image.network(
              'https:$iconUrl',
              height: 50.h,
              width: 50.w,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.cloud_off, color: textColor, size: 40.sp),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Text(
              temperature,
              style: TextStyle(color: textColor, fontSize: 16.sp),
            ),
          ),
        ],
      ),
    );
  }
}
