import 'package:book_summary/resource/style/color/colors.dart';
import 'package:book_summary/staticClass.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: ColorTheme.mainColor,
      ),
      height: MediaQuery.sizeOf(context).height * 0.25,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(
          height: 30,
        ),
        Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: Image(
                image: NetworkImage(
                    StaticClass.image ?? StaticClass.defaultProfileImage))),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 20,
            ),
            Text(
              "${StaticClass.name}",
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(
              width: 5,
            ),
            const Icon(
              Icons.verified,
              size: 20,
              color: Colors.white,
            )
          ],
        ),
      ]),
    );
  }
}
