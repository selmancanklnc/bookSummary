class BookCommentsModel {
  int id;
  int pageNumber;
  String comment;

  BookCommentsModel({
    required this.id,
    required this.pageNumber,
    required this.comment,
  });

  factory BookCommentsModel.fromJson(Map<String, dynamic> json) {
    return BookCommentsModel(
      id: json['Id'],
      pageNumber: json['PageNumber'],
      comment: json['Comment'],
    );
  }
}
