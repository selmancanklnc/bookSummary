import 'package:book_summary/resource/style/color/colors.dart';
import 'package:book_summary/resource/widgets/headerWidget.dart';
import 'package:book_summary/resource/widgets/newestBooksWidget.dart';
import 'package:book_summary/resource/widgets/popularBooksWidget.dart';
import 'package:book_summary/resource/widgets/sliderWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String slectedCategorie = "All";

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return Future.error("Çıkış");
      },
      child: Scaffold(
        backgroundColor: ColorTheme.bgColor,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: AppBar(
              backgroundColor: ColorTheme.bgColor,
            )),
        body: const SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 24),
                HeaderWidget(),
                SizedBox(height: 24),
                SliderWidget(),
                SizedBox(height: 24),
                NewestBooksWidget(),
                SizedBox(height: 24),
                PopularBooksWidget(),
                SizedBox(height: 90),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
