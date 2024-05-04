import 'package:book_summary/resource/widgets/loginWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return Future.error("Çıkış");
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/logBg.jpg",
                      ))),
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 100),
                child: Image(
                    width: 250,
                    height: 250,
                    image: AssetImage(
                      "assets/logo2.png",
                    )),
              ),
            ),
            const Padding(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 40),
                child: LoginWidget())
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
