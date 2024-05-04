import 'package:book_summary/models/sliderModel.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<List<SliderListModel>> getSliderImagesFromFirebaseStorage(
    String folderPath) async {
  List<SliderListModel> sliderImages = [];
  try {
    Reference reference = FirebaseStorage.instance.ref().child(folderPath);
    ListResult result = await reference.listAll();
    for (Reference ref in result.items) {
      String downloadUrl = await ref.getDownloadURL();
      sliderImages.add(SliderListModel(
        routeId: null,
        routeType: null,
        sliderImage: downloadUrl,
      ));
    }
    return sliderImages;
  } catch (e) {
    // print('Error fetching images from Firebase Storage: $e');
    return [];
  }
}
