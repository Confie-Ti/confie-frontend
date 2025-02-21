import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static AppColors? _instance;

  static AppColors get instance {
    _instance ??= AppColors._();
    return _instance!;
  }

  static Color get primary => const Color(0xFFFF6033);
  static Color get onPrimary => const Color(0xFF1E293B);
  static Color get secondary => const Color(0xFF000000);
  static Color get white => const Color(0xFFFFFFFF);
}
