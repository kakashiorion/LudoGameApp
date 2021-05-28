import 'package:flutter/material.dart';
import 'package:ludo_game_app/enums/device_screen_type.dart';
import 'package:ludo_game_app/ui/responsive/responsive_builder.dart';

class ScreenTypeLayout extends StatelessWidget {
  const ScreenTypeLayout(
      {Key? key,
      required this.mobile,
      required this.tablet,
      required this.desktop})
      : super(key: key);

  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) {
        if (sizingInfo.deviceScreenType == DeviceScreenType.Tablet) {
          return tablet;
        }
        if (sizingInfo.deviceScreenType == DeviceScreenType.Desktop) {
          return desktop;
        }
        return mobile;
      },
    );
  }
}
