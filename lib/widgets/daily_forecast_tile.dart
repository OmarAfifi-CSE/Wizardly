import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DailyForecastTile extends StatelessWidget {
  final String day;
  final String iconUrl;
  final String condition;
  final String tempHigh;
  final String tempLow;
  final Color textColor;

  const DailyForecastTile({
    super.key,
    required this.day,
    required this.iconUrl,
    required this.condition,
    required this.tempHigh,
    required this.tempLow,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              day,
              style: TextStyle(color: textColor, fontSize: 16.sp),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Image.network(
                  'https:$iconUrl',
                  height: 40.w,
                  width: 40.w,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.cloud_off, color: textColor, size: 32.sp),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Tooltip(
                    message: condition,
                    child: Text(
                      condition,
                      style: TextStyle(color: textColor, fontSize: 16.sp),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  tempHigh,
                  style: TextStyle(color: textColor, fontSize: 16.sp),
                ),
                SizedBox(width: 12.w),
                Text(
                  tempLow,
                  style: TextStyle(color: textColor, fontSize: 12.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
