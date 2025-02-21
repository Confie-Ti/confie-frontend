import 'package:conformeia/core/styles/colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  static AppTextStyles? _instance;

  static AppTextStyles get instance {
    _instance ??= AppTextStyles._();
    return _instance!;
  }

  TextStyle get smallGray => TextStyle(
      color: AppColors.primary,
      fontSize: 18,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none);

  TextStyle get smallWhite => const TextStyle(
      color: Colors.white,
      fontSize: 15,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.none);

  TextStyle get mediumBlack => TextStyle(
      color: AppColors.secondary,
      fontSize: 20,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.none);
}

extension AppTextStylesExtension on BuildContext {
  AppTextStyles get appTextStyles => AppTextStyles.instance;
}
