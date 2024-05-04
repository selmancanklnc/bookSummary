import 'package:book_summary/models/bookCommentsModel.dart';
import 'package:book_summary/models/bookModel.dart';
import 'package:book_summary/resource/style/color/colors.dart';
import 'package:book_summary/services/bookService.dart';
import 'package:book_summary/services/userService.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localization/localization.dart';

class BookDetailWidget extends StatefulWidget {
  final int bookId;

  const BookDetailWidget({super.key, required this.bookId});

  @override
  State<BookDetailWidget> createState() => _BookDetailWidgetState();
}

class _BookDetailWidgetState extends State<BookDetailWidget> {
  BooksModel? detailModel;
  List<BookCommentsModel> comments = List.empty();
  @override
  void initState() {
    getBookDetail();
    getBookComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: detailModel == null
          ? Center(
              child: CircularProgressIndicator(
              color: ColorTheme.mainColor,
            ))
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 200,
                    height: 300,
                    clipBehavior: Clip.hardEdge,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 40),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        imageUrl: detailModel!.bookImageUrl,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                              color: ColorTheme.mainColor,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 20),
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              detailModel!.bookName,
                              style: TextStyle(
                                  color: ColorTheme.buttonText,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 21),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              detailModel!.categoryName!,
                              style: TextStyle(
                                  color: ColorTheme.categoryText, fontSize: 14),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          detailModel!.bookSummary,
                          style: TextStyle(
                            color: ColorTheme.summaryText,
                            fontSize: 18,
                            letterSpacing: 0.6,
                            wordSpacing: 0.6,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        myComments(),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  ///Notlarım
  Widget myComments() {
    return Column(
      children: [
        for (var i = 0; i < comments.length; i++)
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
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                expandedAlignment: Alignment.centerLeft,
                title: Row(
                  children: [
                    FaIcon(
                      Ionicons.attach_outline,
                      size: 22,
                      color: ColorTheme.buttonIcon,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "${'note'.i18n()} ${i + 1}",
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
                  Text(
                    '${'pageNumber'.i18n()}: ${comments[i].pageNumber}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    comments[i].comment,
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorTheme.mainText,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              )),
      ],
    );
  }

  Future<void> getBookComments() async {
    var user = FirebaseAuth.instance.currentUser;
    var commentResult =
        await BookService().getBookComments(widget.bookId, user!.uid);
    comments = commentResult;
    setState(() {});
  }

  Future<void> getBookDetail() async {
    var languageId = await UserService().checkLanguage();
    var bookDetail =
        await BookService().getBookDetail(widget.bookId, languageId);
    detailModel = bookDetail!;
    setState(() {});
  }
}
