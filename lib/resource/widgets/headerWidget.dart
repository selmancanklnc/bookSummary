import 'package:book_summary/resource/style/color/colors.dart';
import 'package:book_summary/staticClass.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  var padding = 24.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getGreeting(),
                  style: TextStyle(
                    color: ColorTheme.mainText,
                    fontSize: 22,
                    fontFamily: 'Montserrat',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${StaticClass.name}',
                  style: TextStyle(
                    color: ColorTheme.headerText,
                    fontSize: 24,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
              clipBehavior: Clip.hardEdge,
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.circular(50)),
              child: Image(
                  image: NetworkImage(StaticClass.image ??
                      StaticClass.defaultProfileImage))),
        ],
      ),
    );
  }

  ///Karşılama Mesajı
  String getGreeting() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour >= 6 && hour < 12) {
      return 'gm1'.i18n();
    } else if (hour >= 12 && hour < 18) {
      return 'gm2'.i18n();
    } else if (hour >= 18 && hour < 24) {
      return 'gm3'.i18n();
    } else {
      return 'gm4'.i18n();
    }
  }
}
