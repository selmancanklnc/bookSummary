import 'package:book_summary/models/bookModel.dart';
import 'package:book_summary/models/popularBookModel.dart';
import 'package:book_summary/resource/style/color/colors.dart';
import 'package:book_summary/services/bookService.dart';
import 'package:book_summary/services/userService.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class PopularBooksWidget extends StatefulWidget {
  const PopularBooksWidget({super.key});
  @override
  State<PopularBooksWidget> createState() => _PopularBooksWidgetState();
}

class _PopularBooksWidgetState extends State<PopularBooksWidget> {
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
            "popular".i18n(),
            style: TextStyle(
                color: ColorTheme.headerText,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            height: 250,
            child: ListView.builder(
                itemCount: bookDB.length > 5 ? 5 : bookDB.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return PopularBooks(
                    id: bookDB[index].id!,
                    title: bookDB[index].bookName,
                    categoryName: bookDB[index].categoryName!,
                    imgAssetPath: bookDB[index].bookImageUrl,
                  );
                }),
          )
        ],
      ),
    );
  }
}
