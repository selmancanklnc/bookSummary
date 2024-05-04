import 'package:book_summary/models/bookModel.dart';
import 'package:book_summary/resource/routes/routing.dart';
import 'package:book_summary/resource/style/color/colors.dart';
import 'package:book_summary/resource/widgets/bookWidget.dart';
import 'package:book_summary/services/bookService.dart';
import 'package:book_summary/services/userService.dart';
import 'package:book_summary/views/addBookPage.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localization/localization.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  List<BooksModel> bookDB = List.empty();

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
    return WillPopScope(
      onWillPop: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Routing(
                      currentindex: 0,
                    )));
        return Future.error("");
      },
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: AppBar(
                backgroundColor: ColorTheme.mainColor,
              )),
          backgroundColor: ColorTheme.mainColor,
          body: Column(
            children: [
              Container(
                width: double.infinity,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: ColorTheme.mainColor,
                ),
                height: 80,
                // height: MediaQuery.sizeOf(context).height * 0.32,
                child: Column(children: [
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "books".i18n(),
                            style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 100,
                      ),
                      SizedBox(
                        width: 100,
                        child: InkWell(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AddBookPage()));
                            },
                            child: Row(
                              children: [
                                Text(
                                  "new".i18n(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(
                                  Ionicons.add_circle_outline,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                  const Spacer(),
                ]),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      color: ColorTheme.bgColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24))),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        ListView.builder(
                            itemCount: bookDB.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return BooksTile(
                                id: bookDB[index].id!,
                                imgAssetPath: bookDB[index].bookImageUrl,
                                title: bookDB[index].bookName,
                                description: bookDB[index].bookSummary,
                                categoryName: bookDB[index].categoryName!,
                                width: 0,
                                paddingR: 175,
                                trunchTextLimit: 120,
                              );
                            }),
                        const SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
