import 'package:book_summary/resource/style/color/colors.dart';
import 'package:book_summary/resource/widgets/bookDetailWidget.dart';
import 'package:book_summary/services/bookService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localization/localization.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class BookDetails extends StatefulWidget {
  final int bookId;
  const BookDetails({super.key, required this.bookId});
  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  final MaskTextInputFormatter _maskFormatter =
      MaskTextInputFormatter(mask: "####", filter: {"#": RegExp(r'[0-9]')});
  final TextEditingController pageNumberController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorTheme.bgColor,
        appBar: AppBar(
            title: Text(
              'bookDetail'.i18n(),
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: ColorTheme.mainColor,
            foregroundColor: Colors.white,
            actions: [
              PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry>[
                    ///Galeriye Kaydet
                    PopupMenuItem(
                      child: ListTile(
                        leading: const Icon(Ionicons.attach_outline),
                        title: Text('addNote'.i18n()),
                        onTap: () {
                          _showPopup(context);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ];
                },
              ),
            ]),
        body: BookDetailWidget(
          bookId: widget.bookId,
        ));
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorTheme.mainColor,
          title: Text(
            'addNote2'.i18n(),
            style: const TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(
                  top: 15,
                ),
                width: MediaQuery.sizeOf(context).width,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Çerçeve rengi
                    width: 0.2, // Çerçeve kalınlığı
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  color: Colors.white,
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    _maskFormatter,
                    LengthLimitingTextInputFormatter(4)
                  ],
                  controller: pageNumberController,
                  textAlign: TextAlign.left,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  style: TextStyle(color: ColorTheme.mainText),
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    hintText: '${'pageNumber'.i18n()} *',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorTheme.mainColor),
                    ),
                    contentPadding: const EdgeInsets.all(10.0),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 15,
                ),
                width: MediaQuery.sizeOf(context).width,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Çerçeve rengi
                    width: 0.2, // Çerçeve kalınlığı
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: noteController,
                            maxLines: 5,

                  textAlign: TextAlign.left,
                  style: TextStyle(color: ColorTheme.mainText),
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    hintText: '${'writeNote'.i18n()} *',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorTheme.mainColor),
                    ),
                    contentPadding: const EdgeInsets.all(10.0),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                _handleSubmit(context);
              },
              child: Text('save'.i18n(),
                  style: TextStyle(color: ColorTheme.mainColor)),
            ),
          ],
        );
      },
    );
  }

  void _handleSubmit(BuildContext context) async {
    String pageNumber = pageNumberController.text;
    String note = noteController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userId");

    if (pageNumber.isNotEmpty && note.isNotEmpty) {
      var result = await BookService()
          .saveBookComment(widget.bookId, userId!, int.parse(pageNumber), note);
      if (result) {
        pageNumberController.clear();
        noteController.clear();
        // ignore: use_build_context_synchronously
        QuickAlert.show(
          barrierDismissible: false,
          showConfirmBtn: true,
          context: context,
          type: QuickAlertType.success,
          title: "Notunuz Başarıyla Kaydedildi",
          confirmBtnText: 'Tamam',
          confirmBtnColor: ColorTheme.mainColor,
        );
      } else {
        // ignore: use_build_context_synchronously
        QuickAlert.show(
          barrierDismissible: false,
          context: context,
          type: QuickAlertType.warning,
          title: "Bir sorun oluştu, lütfen tekrar deneyin.",
          confirmBtnText: 'Tamam',
          confirmBtnColor: ColorTheme.mainColor,
        );
      }
    } else {
      // ignore: use_build_context_synchronously
      QuickAlert.show(
        barrierDismissible: false,
        context: context,
        type: QuickAlertType.warning,
        title: "Lütfen Gerekli alanları doldurunuz.",
        confirmBtnText: 'Tamam',
        confirmBtnColor: ColorTheme.mainColor,
      );
    }
  }
}
