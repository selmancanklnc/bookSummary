import 'package:book_summary/resource/style/color/colors.dart';
import 'package:flutter/material.dart';

Widget truncateTextSummary(String text, int maxLength) {
  if (text.length <= maxLength) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: const TextStyle(color: Colors.white, fontSize: 12),
    );
  } else {
    String firstLine = text.substring(0, maxLength);
    return Text(
      '$firstLine...',
      textAlign: TextAlign.left,
      style: const TextStyle(color: Colors.white, fontSize: 12),
    );
  }
}

Widget truncateTextHeader(String text, int maxLength) {
  if (text.length <= maxLength) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(
          color: ColorTheme.detailText,
          fontSize: 16,
          fontWeight: FontWeight.bold),
    );
  } else {
    String firstLine = text.substring(0, maxLength);
    return Text(
      '$firstLine...',
      textAlign: TextAlign.left,
      style: TextStyle(
          color: ColorTheme.detailText,
          fontSize: 16,
          fontWeight: FontWeight.bold),
    );
  }
}
