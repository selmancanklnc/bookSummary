class ResultModel {
  bool isSuccess;
  String? message;

  ResultModel({
    required this.isSuccess,
      this.message,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) =>
      ResultModel(
        isSuccess: json["isSuccessful"],
        message: json["message"],
      );
}


class LoginResultModel {
  bool isSuccess;
  String? message;
  

  LoginResultModel({
    required this.isSuccess,
      this.message,
  });

  factory LoginResultModel.fromJson(Map<String, dynamic> json) =>
      LoginResultModel(
        isSuccess: json["isSuccess"],
        message: json["message"],
      );
}