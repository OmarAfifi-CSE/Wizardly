import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherDetailCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final Color labelColor;
  final String value;
  final Color valueColor;

  const WeatherDetailCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.labelColor,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 24.sp),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(color: labelColor, fontSize: 14.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          FittedBox(
            child: Text(
              value,
              style: TextStyle(color: valueColor, fontSize: 16.sp),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
