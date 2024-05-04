class SliderListModel {
  final int? routeId;
  final int? routeType;
  final String sliderImage;

  SliderListModel({
    required this.routeId,
    required this.routeType,
    required this.sliderImage,
  });

  factory SliderListModel.fromJson(Map<String, dynamic> json) =>
      SliderListModel(
        routeId: json["routeId"],
        routeType: json["routeType"],
        sliderImage: json["sliderImage"],
      );

  Map<String, dynamic> toJson() => {
        "routeId": routeId,
        "routeType": routeType,
        "sliderImage": sliderImage,
      };
}
