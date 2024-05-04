import 'dart:ui';
import 'package:book_summary/resource/routes/routing.dart';
import 'package:book_summary/services/userService.dart';
import 'package:book_summary/models/userModel.dart';
import 'package:book_summary/resource/style/color/colors.dart';
import 'package:book_summary/resource/widgets/component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

// ignore: must_be_immutable
class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: MediaQuery.of(context).size.height * (0.30),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.grey.withOpacity(.4),
            width: 1,
          )),
      width: size.width * .9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 30, sigmaX: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              component(() async {
                var result = await UserService().signInWithGoogle();
                if (result.isSuccess) {
                  var user = FirebaseAuth.instance.currentUser;
                  UserModel uModel = UserModel(
                    name: user!.displayName!,
                    email: user.email!,
                    image: user.photoURL,
                    googleId: user.uid,
                  );

                  ///SQL'e Kaydet
                  await UserService().saveUser(uModel);

                  // ignore: use_build_context_synchronously
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Routing(
                                currentindex: 0,
                              )));
                } else {
                  // ignore: use_build_context_synchronously
                  QuickAlert.show(
                    barrierDismissible: false,
                    context: context,
                    type: QuickAlertType.warning,
                    title: "Giriş Başarısız, lütfen tekrar deneyiniz.",
                    confirmBtnText: 'Tamam',
                    text: result.message,
                    confirmBtnColor: ColorTheme.mainColor,
                  );
                }
              }, FontAwesomeIcons.google, 'Google ile giriş yap', Colors.white,
                  MediaQuery.of(context).size),
            ],
          ),
        ),
      ),
    );
  }
}
