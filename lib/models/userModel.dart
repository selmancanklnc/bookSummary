class UserModel {
  String name;
  String email;
  String? image;
  String googleId;
  int? id;
  UserModel(
      {required this.name,
      required this.email,
      this.image,
      required this.googleId,
      this.id});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['Name'],
      email: json['Email'],
      image: json['Image'],
      googleId: json['GoogleId'],
      id: json['Id'],
    );
  }
}
