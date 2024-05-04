import 'package:book_summary/models/bottomBarModel.dart';
import 'package:book_summary/resource/style/color/colors.dart';
import 'package:book_summary/staticClass.dart';
import 'package:book_summary/views/booksPage.dart';
import 'package:book_summary/views/homePage.dart';
import 'package:book_summary/views/profilePage.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Routing extends StatefulWidget {
  Routing({super.key, this.currentindex});
  int? currentindex;
  @override

  // ignore: no_logic_in_create_state
  State<Routing> createState() => _RoutingState(currentIndex: currentindex);
}

class _RoutingState extends State<Routing> {
  List routing = [
    const MyHomePage(),
    const BooksPage(),
    const ProfilePage(),
  ];
  int? currentIndex;
  _RoutingState({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        routing.elementAt(currentIndex ?? 0),
        if (StaticClass.pageLast == false) ...[
          Container(
            margin: EdgeInsets.all(displayWidth * .05),
            height: displayWidth * .155,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ColorTheme.mainColor,
                borderRadius: const BorderRadius.all(Radius.circular(35))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...List.generate(bottomBar.length, (i) {
                  return InkWell(
                    onTap: () {
                      currentIndex = i;
                      setState(() {});
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        bottomBar[i],
                        const SizedBox(height: 4),
                        currentIndex == i
                            ? Container(
                                width: 4,
                                height: 4,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              )
                            : Container()
                      ],
                    ),
                  );
                })
              ],
            ),
          ),
        ]
      ],
    ));
  }
}
