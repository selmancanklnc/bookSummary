import 'package:book_summary/resource/style/color/colors.dart';
import 'package:book_summary/staticClass.dart';
import 'package:book_summary/views/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restart_app/restart_app.dart';
import 'package:localization/localization.dart';

class ProfileSettingsWidget extends StatefulWidget {
  const ProfileSettingsWidget({super.key});

  @override
  State<ProfileSettingsWidget> createState() => _ProfileSettingsWidgetState();
}

class _ProfileSettingsWidgetState extends State<ProfileSettingsWidget> {
  int? languageId;
  bool darkThemeActive = StaticClass.colorTheme == 2;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    checkLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.sizeOf(context).height * 0.75,
      ),
      decoration: BoxDecoration(
          color: ColorTheme.bgColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24))),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Tema Seçimi
              Container(
                padding: const EdgeInsets.only(right: 10, left: 10),
                margin: const EdgeInsets.only(top: 15, bottom: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: ColorTheme.mainColor, width: 0.5),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  color: ColorTheme.buttonBg,
                ),
                child: ExpansionTile(
                    collapsedIconColor: ColorTheme.buttonIcon,
                    iconColor: ColorTheme.buttonIcon,
                    title: Row(
                      children: [
                        FaIcon(
                          Ionicons.color_palette_outline,
                          color: ColorTheme.buttonIcon,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          'selectTheme'.i18n(),
                          style: TextStyle(
                            color: ColorTheme.buttonText,
                            fontSize: 16,
                            fontFamily: 'Hellix',
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.only(
                                top: 5, right: 10, left: 10, bottom: 5),
                            decoration: ShapeDecoration(
                              color: ColorTheme.buttonTileBg,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(darkThemeActive == true
                                        ? Icons.dark_mode
                                        : Icons.light_mode),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(darkThemeActive == true
                                        ? "darkTheme".i18n()
                                        : "lightTheme".i18n()),
                                  ],
                                ),
                                Switch(
                                  value: darkThemeActive,
                                  activeColor: ColorTheme.mainColor,
                                  inactiveTrackColor: Colors.grey[200],
                                  onChanged: (newValue) async {
                                    setState(() {
                                      darkThemeActive = newValue;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              if (darkThemeActive == true) {
                                prefs.setInt("colorTheme", 2);
                                StaticClass.colorTheme = 2;
                              } else {
                                prefs.setInt("colorTheme", 1);
                                StaticClass.colorTheme = 1;
                              }
                              // ignore: use_build_context_synchronously
                              QuickAlert.show(
                                barrierDismissible: false,
                                showConfirmBtn: true,
                                onConfirmBtnTap: () async {
                                  Restart.restartApp();
                                },
                                context: context,
                                type: QuickAlertType.success,
                                title: "themeChanged".i18n(),
                                confirmBtnText: 'ok'.i18n(),
                                confirmBtnColor: ColorTheme.mainColor,
                              );
                            },
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.95,
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                ),
                                color: ColorTheme.mainColor,
                              ),
                              child: Center(
                                child: Text(
                                  'save_change'.i18n(),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontFamily: 'Hellix',
                                      fontSize: 14,
                                      letterSpacing:
                                          0.5 /*percentages not used in flutter. defaulting to zero*/,
                                      fontWeight: FontWeight.w600,
                                      height: 1.1428571428571428),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ]),
              ),

              /// Dil Seçimi
              Container(
                padding: const EdgeInsets.only(right: 10, left: 10),
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: ColorTheme.mainColor, width: 0.5),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  color: ColorTheme.buttonBg,
                ),
                child: ExpansionTile(
                    collapsedIconColor: ColorTheme.buttonIcon,
                    iconColor: ColorTheme.buttonIcon,
                    title: Row(
                      children: [
                        FaIcon(
                          Icons.language_outlined,
                          size: 22,
                          color: ColorTheme.buttonIcon,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          'select_language'.i18n(),
                          style: TextStyle(
                            color: ColorTheme.buttonText,
                            fontSize: 16,
                            fontFamily: 'Hellix',
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                languageId = 1;
                              });
                            },
                            onDoubleTap: () {},
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.only(
                                  top: 15, right: 20, left: 20, bottom: 15),
                              decoration: ShapeDecoration(
                                color: ColorTheme.buttonTileBg,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "turkish".i18n(),
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 16,
                                      fontFamily: 'Hellix',
                                    ),
                                  ),
                                  Visibility(
                                      visible: languageId == 1,
                                      child: Icon(Icons.check,
                                          color: ColorTheme.mainColor))
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                languageId = 2;
                              });
                            },
                            onDoubleTap: () {},
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.only(
                                  top: 15, right: 20, left: 20, bottom: 15),
                              decoration: ShapeDecoration(
                                color: ColorTheme.buttonTileBg,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "english".i18n(),
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.8),
                                      fontFamily: 'Hellix',
                                      fontSize: 16,
                                    ),
                                  ),
                                  Visibility(
                                      visible: languageId == 2,
                                      child: Icon(
                                        Icons.check,
                                        color: ColorTheme.mainColor,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          var language = languageId == 1 ? 'tr' : 'en';
                          SharedPreferences localStorage =
                              await SharedPreferences.getInstance();

                          localStorage.setString('localLanguage', language);

                          // ignore: use_build_context_synchronously
                          QuickAlert.show(
                            showConfirmBtn: true,
                            onConfirmBtnTap: () async {
                              Restart.restartApp();
                            },
                            context: context,
                            type: QuickAlertType.success,
                            title: "saved_successfully".i18n(),
                            confirmBtnText: 'ok'.i18n(),
                            confirmBtnColor: ColorTheme.mainColor,
                          );
                        },
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.95,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                            color: ColorTheme.mainColor,
                          ),
                          child: Center(
                            child: Text(
                              'save_changes'.i18n(),
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontFamily: 'Hellix',
                                  fontSize: 14,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w600,
                                  height: 1.1428571428571428),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ]),
              ),

              /// Oturumu Kapat
              InkWell(
                onDoubleTap: () {
                  return;
                },
                onTap: () async {
                  QuickAlert.show(
                      context: context,
                      type: QuickAlertType.confirm,
                      title: "logout2".i18n(),
                      confirmBtnText: 'logout'.i18n(),
                      cancelBtnText: 'cancel'.i18n(),
                      text: "logoutMessage".i18n(),
                      confirmBtnColor: Colors.red,
                      onConfirmBtnTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.clear();
                        await _auth.signOut();
                        // ignore: use_build_context_synchronously
                        Navigator.of(context, rootNavigator: true).pop();
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      });
                },
                child: Container(
                    margin: const EdgeInsets.only(bottom: 5, top: 10),
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        color: Colors.red),
                    height: 55,
                    width: MediaQuery.sizeOf(context).width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            FaIcon(
                              // ignore: deprecated_member_use
                              FontAwesomeIcons.signOut,
                              size: 22,
                              color: Colors.amber[50],
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              "logout2".i18n(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Hellix',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.keyboard_arrow_right_sharp,
                          color: Colors.white,
                        )
                      ],
                    )),
              ),

              const SizedBox(
                height: 90,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkLanguage() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var localLanguage = localStorage.getString('localLanguage');
    if (localLanguage == 'en') {
      setState(() {
        languageId = 2;
      });
    } else if (localLanguage == 'tr') {
      setState(() {
        languageId = 1;
      });
    } else {
      setState(() {
        languageId = 1;
      });
    }
  }
}
