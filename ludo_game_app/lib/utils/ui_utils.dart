import 'package:flutter/material.dart';
import 'package:ludo_game_app/enums/device_screen_type.dart';

DeviceScreenType getDeviceType(MediaQueryData mediaQuery) {
  double deviceWidth = mediaQuery.size.shortestSide;

  if (deviceWidth >= 960) {
    return DeviceScreenType.Desktop;
  } else if (deviceWidth >= 600) {
    return DeviceScreenType.Tablet;
  }
  return DeviceScreenType.Mobile;
}
