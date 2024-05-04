import 'package:book_summary/staticClass.dart';
import 'package:flutter/material.dart';

Color darkGreen = const Color(0xff007084);
Color greyColor = const Color(0xffBDC3C7);

class ColorTheme {
  /// Açık Tema - 1   /// Koyu Tema -2
  static int colorTheme = StaticClass.colorTheme;

  ///----Ana Renk---///
  static Color get mainColor {
    return const Color.fromARGB(255, 109, 145, 152);
  }

  ///----Arka Plan Rengi---///
  static Color get bgColor {
    if (colorTheme == 1) {
      return Colors.white;
    } else if (colorTheme == 2) {
      return const Color.fromARGB(255, 84, 84, 84);
    }
    return Colors.white;
  }

  ///----Yazı Renkleri---///
  ///Başlık ve Ana Metin
  static Color get headerText {
    if (colorTheme == 1) {
      return const Color(0xff333333);
    } else if (colorTheme == 2) {
      return const Color(0xffffffff);
    }
    return const Color(0xff333333);
  }

  ///Alt Başlık ve İkincil Metin
  static Color get mainText {
    if (colorTheme == 1) {
      return const Color(0xff666666);
    } else if (colorTheme == 2) {
      return const Color(0xffC8C8C8);
    }
    return const Color(0xff666666);
  }

  /// Aksiyon ve Vurgu Metni
  static Color get detailText {
    if (colorTheme == 1) {
      return Colors.tealAccent;
    } else if (colorTheme == 2) {
      return Colors.orange;
    }

    return Colors.tealAccent;
  }

  /// Alt Başlık
  static Color get descriptionText {
    if (colorTheme == 1) {
      return const Color.fromARGB(255, 109, 145, 152);
    } else if (colorTheme == 2) {
      return Colors.orange;
    }

    return const Color.fromARGB(255, 109, 145, 152);
  }

  /// Kategori Yazı
  static Color get categoryText {
    if (colorTheme == 1) {
      return darkGreen;
    } else if (colorTheme == 2) {
      return Colors.orange;
    }

    return const Color.fromARGB(255, 109, 145, 152);
  }

  /// Açıklama özet yazı
  static Color get summaryText {
    if (colorTheme == 1) {
      return Colors.grey;
    } else if (colorTheme == 2) {
      return Colors.white;
    }

    return const Color.fromARGB(255, 109, 145, 152);
  }



  /// Buton
  static Color get buttonBg {
    if (colorTheme == 1) {
      return Colors.white;
    } else if (colorTheme == 2) {
      return Colors.blueGrey;
    }

    return Colors.white;
  }

  /// Buton Text
  static Color get buttonText {
    if (colorTheme == 1) {
      return Colors.black;
    } else if (colorTheme == 2) {
      return Colors.white;
    }

    return Colors.black;
  }

  /// Buton Icon
  static Color get buttonIcon {
    if (colorTheme == 1) {
      return const Color.fromARGB(255, 109, 145, 152);
    } else if (colorTheme == 2) {
      return Colors.white;
    }

    return const Color.fromARGB(255, 109, 145, 152);
  }

  /// Buton Icon
  static Color get buttonTileBg {
    if (colorTheme == 1) {
      return Colors.white;
    } else if (colorTheme == 2) {
      return Color.fromARGB(255, 224, 224, 224);
    }

    return const Color.fromARGB(255, 109, 145, 152);
  }
}
