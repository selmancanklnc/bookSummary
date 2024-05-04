import 'package:book_summary/resource/routes/routing.dart';
import 'package:book_summary/resource/style/color/colors.dart';
import 'package:book_summary/resource/widgets/profileSettingsWidget.dart';
import 'package:book_summary/resource/widgets/profileWidget.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
        onWillPop: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Routing(
                        currentindex: 0,
                      )));
          return Future.error("");
        },
        child: Scaffold(
            backgroundColor: ColorTheme.mainColor,
            body: const SingleChildScrollView(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                ProfileWidget(),
                ProfileSettingsWidget(),
              ],
            ))));
  }
}
