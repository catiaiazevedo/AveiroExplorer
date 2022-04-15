class AllCategoriesModel {
  String image;
  String color;

  AllCategoriesModel(this.image, this.color);
}

List<AllCategoriesModel> categories = allcategoriesData
    .map((item) => AllCategoriesModel(item['image']!, item['color']!))
    .toList();

var allcategoriesData = [
  {"image": "assets/images/img_museus.png", "color": "0xFFE0E0E0"},
  {"image": "assets/images/img_monumentos.png", "color": "0xFFEAF8E8"},
  {"image": "assets/images/img_atividades.png", "color": "0xFFFFF8E1"},
  {"image": "assets/images/img_hoteis.png", "color": "0xFFFEF1ED"},
  {"image": "assets/images/img_restaurantes.png", "color": "0xFFEDF6FE"},
];
