import 'package:book_summary/resource/style/color/colors.dart';
import 'package:book_summary/resource/widgets/truncaTextWidget.dart';
import 'package:book_summary/views/bookDetailPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BooksTile extends StatelessWidget {
  final String imgAssetPath, title, description, categoryName;
  final int id;
  final int width;
  final int paddingR;
  final int trunchTextLimit;

  const BooksTile({
    super.key,
    required this.id,
    required this.description,
    required this.title,
    required this.categoryName,
    required this.imgAssetPath,
    required this.width,
    required this.paddingR,
    required this.trunchTextLimit,
  });

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
        height: 180,
        margin: const EdgeInsets.only(right: 16),
        alignment: Alignment.bottomLeft,
        child: Stack(
          children: <Widget>[
            Container(
              height: 180,
              alignment: Alignment.bottomLeft,
              child: Container(
                width: MediaQuery.of(context).size.width - width,
                height: 140,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: ColorTheme.mainColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 110,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - paddingR,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          truncateTextHeader(title, 15),
                          const Spacer(),
                          truncateTextSummary(description, trunchTextLimit),
                          const Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                categoryName,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: ColorTheme.detailText,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[300],
              ),
              height: 150,
              width: 100,
              margin: const EdgeInsets.only(
                left: 12,
                top: 20,
              ),
              child: CachedNetworkImage(
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
          ],
        ),
      ),
    );
  }
}
