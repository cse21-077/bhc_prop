import 'dart:ui';

class HouseItem {
  final String title;
  final String description;
  final List<ImageItem> images;
  final Color color;
  final Color buttonBgColor;
  final Color buttonTextColor;
  final int price;

  String get mainFullSizeImage => images.first.fullSizeImage;

  HouseItem({
    required this.title,
    required this.description,
    required this.images,
    required this.color,
    required this.buttonBgColor,
    required this.buttonTextColor,
    required this.price,
  });
}

class ImageItem {
  final String fullSizeImage;
  final String thumbnailImage;

  ImageItem({
    required this.fullSizeImage,
    required this.thumbnailImage,
  });
}

final houseItems = [
  HouseItem(
    title: 'House',
    description:
    'A residental House by Botswana Housing Corporation',
    images: [
      ImageItem(
        fullSizeImage: 'assets/images/2.png',
        thumbnailImage: 'assets/images/2.png',
      ),
    ],
    color: const Color(0xFF3D4D69),
    buttonBgColor: const Color(0xFF243D5E),
    buttonTextColor: const Color(0xFFF4F4F4),
    price: 25,
  ),
  HouseItem(
    title: 'Flats',
    description:
    'Flats by Botswana Housing Corporation',
    images: [
      ImageItem(
        fullSizeImage: 'assets/images/5.png',
        thumbnailImage: 'assets/images/5.png',
      ),
    ],
    color: const Color(0xFF3C2E2D),
    buttonBgColor: const Color(0xFF212121),
    buttonTextColor: const Color(0xFFF4F4F4),
    price: 30,
  ),
  HouseItem(
    title: 'Townhouse',
    description:
    'Townhouse property by Botswana Housing Corporation',
    images: [
      ImageItem(
        fullSizeImage: 'assets/images/10.png',
        thumbnailImage: 'assets/images/10.png',
      ),
    ],
    color: const Color(0xFF40474A),
    buttonBgColor: const Color(0xFFF4F4F4),
    buttonTextColor: const Color(0xFF150A0A),
    price: 30,
  ),
];