import 'package:flutter/material.dart';
import 'package:real_time_mobile_app/theme/color_schemes.g.dart';

class AppTheme {
  static final ThemeData theme =
      ThemeData.from(colorScheme: lightColorScheme, useMaterial3: true)
          .copyWith();
  static final ThemeData darkTheme =
      ThemeData.from(colorScheme: darkColorScheme, useMaterial3: true)
          .copyWith();
}
