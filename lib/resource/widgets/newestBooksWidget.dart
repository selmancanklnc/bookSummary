import 'dart:math';
import 'package:book_summary/models/bookModel.dart';
import 'package:book_summary/resource/style/color/colors.dart';
import 'package:book_summary/resource/widgets/bookWidget.dart';
import 'package:book_summary/services/bookService.dart';
import 'package:book_summary/services/userService.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class NewestBooksWidget extends StatefulWidget {
  const NewestBooksWidget({super.key});

  @override
  State<NewestBooksWidget> createState() => _NewestBooksWidgetState();
}

class _NewestBooksWidgetState extends State<NewestBooksWidget> {
  List<BooksModel> bookDB = [];

  @override
  void initState() {
    super.initState();
    getBooks();
  }

  Future<void> getBooks() async {
    var languageId = await UserService().checkLanguage();

    var books = await BookService().getBooks(languageId);
    bookDB = books;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'recent'.i18n(),
            style: TextStyle(
                color: ColorTheme.headerText,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 180,
            child: ListView.builder(
                itemCount: min(2, bookDB.length),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  int reversedIndex = bookDB.length - 1 - index;
                  return BooksTile(
                    id: bookDB[reversedIndex].id!,
                    imgAssetPath: bookDB[reversedIndex].bookImageUrl,
                    title: bookDB[reversedIndex].bookName,
                    description: bookDB[reversedIndex].bookSummary,
                    categoryName: bookDB[reversedIndex].categoryName!,
                    width: 80,
                    paddingR: 220,
                    trunchTextLimit: 90,
                  );
                }),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
