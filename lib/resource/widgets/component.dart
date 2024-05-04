import 'package:flutter/material.dart';
 
Widget component(VoidCallback voidCallback, IconData icon, String buttonText,
    Color textColor, Size sizeContex) {
  Size size = sizeContex;
  return InkWell(
    onTap: voidCallback,
    child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        height: size.width / 8,
        width: size.width / 1.25,
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: size.width / 30),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 0.1),
          color: Colors.white.withOpacity(.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
            ),
            Text(
              buttonText,
              style: TextStyle(color: textColor, fontSize: 20),
            ),
            Opacity(
              opacity: 0,
              child: Icon(
                icon,
                color: Colors.white,
              ),
            )
          ],
        )),
  );
}
