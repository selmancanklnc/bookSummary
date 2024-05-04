class BooksModel {
  int? id;
  String bookName;
  String bookSummary;
  String bookGenre;
  String? categoryName;
  String bookImageUrl;

  BooksModel({
    this.id,
    required this.bookName,
    required this.bookSummary,
    required this.bookGenre,
    this.categoryName,
    required this.bookImageUrl,
  });

  factory BooksModel.fromJson(Map<String, dynamic> json) {
    return BooksModel(
      id: json['Id'],
      bookName: json['BookName'],
      bookSummary: json['BookSummary'],
      bookGenre: json['BookGenre'],
      categoryName: json['CategoryName'],
      bookImageUrl: json['BookImageUrl'],
    );
  }
}

