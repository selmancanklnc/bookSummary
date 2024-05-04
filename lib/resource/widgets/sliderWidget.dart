import 'package:book_summary/models/sliderModel.dart';
import 'package:book_summary/resource/style/color/colors.dart';
import 'package:book_summary/services/sliderService.dart';
import 'package:book_summary/staticClass.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({Key? key}) : super(key: key);

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  int _current = 0;
  final CarouselController controller = CarouselController();
  List<Widget>? imageSliders;
  List<SliderListModel> sliders = StaticClass.sliders;

  @override
  void initState() {
    super.initState();
    getSlider();
  }

  Future<void> getSlider() async {
    if (sliders.isEmpty) {
      List<SliderListModel> sliders =
          await getSliderImagesFromFirebaseStorage('images/slider');
      StaticClass.sliders = sliders;
      List<Widget> imageSlidersResult = StaticClass.sliders.map((item) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRect(
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: item.sliderImage,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      color: ColorTheme.mainColor,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        );
      }).toList();
      setState(() {
        imageSliders = imageSlidersResult;
      });
    } else {
      List<Widget> imageSlidersResult = StaticClass.sliders.map((item) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRect(
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: item.sliderImage,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      color: ColorTheme.mainColor,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        );
      }).toList();
      setState(() {
        imageSliders = imageSlidersResult;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (imageSliders != null)
          CarouselSlider(
            carouselController: controller,
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
              viewportFraction: 1,
              clipBehavior: Clip.none,
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            ),
            items: imageSliders!,
          ),
        if (imageSliders != null)
          Positioned(
            bottom: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.1,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: ShapeDecoration(
                color: const Color(0x3304060E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imageSliders!.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => controller.animateToPage(entry.key),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (_current == entry.key
                              ? Colors.white
                              : Colors.grey)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
      ],
    );
  }
}
