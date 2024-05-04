 import 'package:book_summary/resource/style/color/colors.dart';
import 'package:book_summary/views/bookDetailPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PopularBooks extends StatelessWidget {
  final String title, categoryName, imgAssetPath;
  final int id;
  const PopularBooks(
      {super.key,
      required this.title,
      required this.id,
      required this.categoryName,
      required this.imgAssetPath});

  @override
  Widget build(BuildContext context) {
     return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetails(
              bookId: id,
            ),
          ),
        );
      },
      child: Container(
        width: 110,
        padding: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[300],
              ),
              height: 170,
              child: CachedNetworkImage(
                height: 170,
                fit: BoxFit.cover,
                imageUrl: imgAssetPath,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      color: ColorTheme.mainColor,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Text(
              title,
              style: TextStyle(
                  color: ColorTheme.mainText,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
            Text(
              categoryName,
              style: TextStyle(color: ColorTheme.descriptionText, fontSize: 13),
            )
          ],
        ),
      ),
    );
  }
}
