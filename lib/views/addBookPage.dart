import 'dart:io';
 import 'package:book_summary/models/categoryModel.dart';
import 'package:book_summary/resource/routes/routing.dart';
import 'package:book_summary/resource/style/color/colors.dart';
import 'package:book_summary/services/bookService.dart';
import 'package:book_summary/services/categoryService.dart';
import 'package:book_summary/services/userService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:localization/localization.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
 
class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();
  String? headerImage;
  XFile? selectedImg;
  int? categoryId;
  List<CategoryModel> categories = List.empty();

  Map<String, int> categoryIdMap = {};

  Future<void> generateCategoryIdMap() async {
    var languageId = await UserService().checkLanguage();

    categories = await CategoryService().getCategories(languageId);
    setState(() {});
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        headerImage = pickedImage.path;
        selectedImg = pickedImage;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    generateCategoryIdMap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.bgColor,
      appBar: AppBar(
        title: Text(
          'addBook'.i18n(),
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ColorTheme.mainColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),

                ///TEMEL BİLGİLER
                Container(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  margin: const EdgeInsets.only(top: 10, bottom: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorTheme.mainColor, width: 0.5),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    color: Colors.white,
                  ),
                  child: ExpansionTile(
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      expandedAlignment: Alignment.centerLeft,
                      iconColor: ColorTheme.mainColor,
                      title: Row(
                        children: [
                          FaIcon(
                            Ionicons.reorder_four_outline,
                            size: 22,
                            color: ColorTheme.mainColor,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            'base'.i18n(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Hellix',
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                      children: [
                        //Kitap Adı
                        Text(
                          "bookName".i18n(),
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16,
                            fontFamily: 'Hellix',
                            fontWeight: FontWeight.w600,
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
                            controller: _nameController,
                            textAlign: TextAlign.left,
                            maxLines: 5,
                            style: TextStyle(color: ColorTheme.mainText),
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              hintText: '${'bookName'.i18n()} *',
                              hintStyle: const TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorTheme.mainColor),
                              ),
                              contentPadding: const EdgeInsets.all(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        //Kitap Özeti
                        Text(
                          "bookSummary".i18n(),
                          style: const TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16,
                            fontFamily: 'Hellix',
                            fontWeight: FontWeight.w600,
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
                            controller: _summaryController,
                            textAlign: TextAlign.left,
                            maxLines: 5,
                            style: TextStyle(color: ColorTheme.mainText),
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              hintText: '${'bookSummary'.i18n()} *',
                              hintStyle: const TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorTheme.mainColor),
                              ),
                              contentPadding: const EdgeInsets.all(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),

                        //Kitap Türü
                        Text(
                          "bookGen".i18n(),
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16,
                            fontFamily: 'Hellix',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          width: MediaQuery.sizeOf(context).width,
                          height: 48,
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
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<int>(
                              isExpanded: true,
                              hint: Text(
                                '${'bookGen'.i18n()} *',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              items: categories
                                  .map(
                                    (CategoryModel item) =>
                                        DropdownMenuItem<int>(
                                      value: item.id,
                                      child: Text(
                                        item.categoryName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: ColorTheme.mainText,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              value: categoryId,
                              onChanged: (int? value) {
                                setState(() {
                                  categoryId = value;
                                });
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                height: 40,
                                width: 140,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                      ]),
                ),

                ///RESİMLER
                Container(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  margin: const EdgeInsets.only(top: 10, bottom: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorTheme.mainColor, width: 0.5),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    color: Colors.white,
                  ),
                  child: ExpansionTile(
                      expandedAlignment: Alignment.centerLeft,
                      iconColor: ColorTheme.mainColor,
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      title: Row(
                        children: [
                          FaIcon(
                            Ionicons.image_outline,
                            size: 22,
                            color: ColorTheme.mainColor,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            'bookImage'.i18n(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Hellix',
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          "${'bookImage2'.i18n()} *",
                          style: const TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16,
                            fontFamily: 'Hellix',
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: GestureDetector(
                              onTap: _getImage,
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 0.5,
                                    color: ColorTheme.mainColor,
                                  ),
                                ),
                                width: 100,
                                height: 150,
                                child: headerImage != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        clipBehavior: Clip.hardEdge,
                                        child: Image.file(
                                          File(headerImage!),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Icon(
                                        Icons.file_upload_outlined,
                                        color: ColorTheme.mainText,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                      ]),
                ),

                ///Oluştur Butonu
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: InkWell(
                    onTap: () async {
                      if (_nameController.text.isEmpty ||
                          _summaryController.text.isEmpty ||
                          categoryId == null ||
                          headerImage == null) {
                        QuickAlert.show(
                          barrierDismissible: false,
                          context: context,
                          type: QuickAlertType.warning,
                          title: "emptyError".i18n(),
                          confirmBtnText: 'ok'.i18n(),
                          confirmBtnColor: ColorTheme.mainColor,
                        );
                      } else {
                        try {
                          EasyLoading.show(
                            status: "saving".i18n(),
                          );
                          var result = await BookService().saveBook(
                              _nameController.text,
                              _summaryController.text,
                              categoryId.toString(),
                              headerImage);
                          if (result) {
                            // ignore: use_build_context_synchronously
                            QuickAlert.show(
                              barrierDismissible: false,
                              showConfirmBtn: true,
                              onConfirmBtnTap: () async {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Routing(
                                              currentindex: 1,
                                            )));
                              },
                              context: context,
                              type: QuickAlertType.success,
                              title: "succesAdd".i18n(),
                              confirmBtnText: 'ok'.i18n(),
                              confirmBtnColor: ColorTheme.mainColor,
                            );
                          }
                        } catch (e) {
                          // ignore: use_build_context_synchronously
                          EasyLoading.dismiss(animation: true);
                          // ignore: use_build_context_synchronously
                          QuickAlert.show(
                            barrierDismissible: false,
                            context: context,
                            type: QuickAlertType.warning,
                            title: "bookAddError".i18n(),
                            confirmBtnText: 'ok'.i18n(),
                            confirmBtnColor: ColorTheme.mainColor,
                          );
                        } finally {
                          EasyLoading.dismiss(animation: true);
                        }
                      }
                    },
                    child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.84,
                        height: 48,
                        child: Stack(children: <Widget>[
                          Center(
                              child: Container(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.84,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                      bottomLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ),
                                    color: ColorTheme.mainColor,
                                  ))),
                          Center(
                              child: Text(
                            "save".i18n(),
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontFamily: 'Hellix',
                                fontSize: 14,
                                letterSpacing:
                                    0.5 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.w600,
                                height: 1.1428571428571428),
                          )),
                        ])),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
