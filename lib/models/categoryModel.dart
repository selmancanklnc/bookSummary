class CategoryModel {
  int? id;
  String categoryName;

  CategoryModel({
    this.id,
    required this.categoryName,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['Id'],
      categoryName: json['CategoryName'],
    );
  }
}
