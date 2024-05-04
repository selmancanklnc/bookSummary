import 'package:book_summary/services/userService.dart';
import 'package:book_summary/firebase_options.dart';
import 'package:book_summary/resource/routes/routing.dart';
import 'package:book_summary/resource/style/color/colors.dart';
import 'package:book_summary/staticClass.dart';
import 'package:book_summary/views/loginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

late String? userId;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userId = prefs.getString("userId");
  if (userId != null) {
    var user = await UserService().getUserByGoogleId(userId!);
    if (user != null) {
      StaticClass.name = user.name;
      StaticClass.image = user.image;
      StaticClass.email = user.email;
    }
  }
  var colorTheme = prefs.getInt("colorTheme");
  StaticClass.colorTheme = colorTheme ?? 1;
  LocalJsonLocalization.delegate.directories = ['lib/resource/language/'];
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  var localLanguage = localStorage.getString('localLanguage');
  runApp(MaterialApp(
      localeResolutionCallback: (locale, supportedLocales) {
        if (localLanguage == null) {
          localLanguage = locale?.languageCode;
          localStorage.setString('localLanguage', localLanguage!);
        }
        if (localLanguage == 'en') {
          return const Locale('en', 'US');
        } else {
          return const Locale('tr', 'TR');
        }
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        LocalJsonLocalization.delegate,
        MapLocalization.delegate,
      ],
      home: const MyApp(),
      debugShowCheckedModeBanner: false,
      routes: const <String, WidgetBuilder>{},
      builder: EasyLoading.init()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showSemanticsDebugger: false,
      title: 'Book Summary App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ColorTheme.mainColor,
      ),
      home: userId == null ? const LoginPage() : Routing(currentindex: 0),
    );
  }
}
